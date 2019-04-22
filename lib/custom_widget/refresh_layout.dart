import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux_mall/custom_widget/tweens.dart';

enum RefreshState {
  //正常状态
  NORMAL,
  //上下拉拖拽
  PULL,
  //拖拽中，已经满足上下拉刷新范围，释放刷新
  RELEASE_TO_REFRESH,
  //刷新中
  REFRESHING,
  //刷新完成
  REFRESH_COMPLETE,
}

enum PullDirection {
  DOWN,
  UP,
  IDLE,
}

class RefreshLayout extends StatefulWidget {
  final RefreshBodyBuilder headerBuilder;
  final RefreshBodyBuilder footerBuilder;
  final RefreshCallback onRefresh;
  final RefreshCallback onLoadMore;

  RefreshLayout(
      {@required this.onRefresh,
      @required this.onLoadMore,
      this.headerBuilder = const DefaultRefreshBodyBuilder(true),
      this.footerBuilder = const DefaultRefreshBodyBuilder(false)});

  @override
  _RefreshLayoutState createState() => _RefreshLayoutState();
}

class _RefreshLayoutState extends State<RefreshLayout>
    with TickerProviderStateMixin {
  final double _scrollLimit = 300;
  final double _refreshExtent = 80;
  RefreshState _state = RefreshState.NORMAL;
  Offset _overScrollOffset = Offset.zero;
  AnimationController _controller;

  PullDirection get _pullDirection {
    if (_overScrollOffset.dy > 0) {
      return PullDirection.DOWN;
    } else if (_overScrollOffset.dy < 0) {
      return PullDirection.UP;
    } else {
      return PullDirection.IDLE;
    }
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    double topHeight =
        _pullDirection == PullDirection.DOWN ? _overScrollOffset.dy.abs() : 0;
    double bottomHeight =
        _pullDirection == PullDirection.UP ? _overScrollOffset.dy.abs() : 0;
    return Stack(
      children: <Widget>[
        widget.headerBuilder.buildTip(_state, topHeight),
        Align(
          alignment: Alignment.bottomCenter,
          child: widget.footerBuilder.buildTip(_state, bottomHeight),
        ),
        Transform.translate(
          offset: _overScrollOffset,
          child: NotificationListener<ScrollNotification>(
            onNotification: handleScrollNotification,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.grey[100]),
              child: ListView.builder(
                itemBuilder: buildItem,
                itemCount: 30,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildItem(BuildContext context, int index) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Text('item $index'),
      ),
    );
  }

  bool handleScrollNotification(ScrollNotification notification) {
    //debugPrint(notification.toString());
    if (notification.depth != 0) {
      return false;
    }
    if (_controller.isAnimating) {
      return false;
    }
    if (notification is OverscrollNotification) {
      if (notification.velocity == 0 && notification.dragDetails != null) {
        //上下拉状态
        setState(() {
          double factor = 1; //阻尼因子
          if (_overScrollOffset.dy.abs() > 0) {
            factor -= _overScrollOffset.dy.abs() / _scrollLimit;
          }
          _overScrollOffset = _overScrollOffset.translate(
              0, notification.dragDetails.delta.dy * factor);
          //debugPrint('factor--:$factor----_overScrollOffset:$_overScrollOffset');
          _updatePullRefreshState();
        });
      }
    }
    if (notification is ScrollEndNotification) {
      if (_state == RefreshState.PULL ||
          _state == RefreshState.RELEASE_TO_REFRESH) {
        //手离开，fling滚动
        if (_overScrollOffset.dy.abs() < _refreshExtent) {
          _animateToNormal();
        } else {
          _handleRefresh();
        }
      }
    }
    if (notification is ScrollUpdateNotification) {
      //debugPrint(notification.toString());
      if (_state == RefreshState.PULL ||
          _state == RefreshState.RELEASE_TO_REFRESH) {
        //在上下拉的状态中，滚动了scroll里面的内容，需要将上下拉进行回滚
        setState(() {
          if (notification.dragDetails != null) {
            if (_pullDirection == PullDirection.DOWN) {
              //避免回滚过头
              _overScrollOffset += notification.dragDetails.delta;
              if (_overScrollOffset.dy < 0) {
                _overScrollOffset = Offset.zero;
                _state = RefreshState.NORMAL;
              }
              _updatePullRefreshState();
            } else if (_pullDirection == PullDirection.UP) {
              _overScrollOffset += notification.dragDetails.delta;
              if (_overScrollOffset.dy > 0) {
                _overScrollOffset = Offset.zero;
                _state = RefreshState.NORMAL;
              }
              _updatePullRefreshState();
            }
          } else {
            //手离开，fling滚动
            if (_overScrollOffset.dy.abs() < _refreshExtent) {
              _animateToNormal();
            } else {
              _handleRefresh();
            }
          }
        });
      }
    }
    return false;
  }

  void _updatePullRefreshState() {
    if (_overScrollOffset.dy.abs() < _refreshExtent) {
      _state = RefreshState.PULL;
    } else {
      _state = RefreshState.RELEASE_TO_REFRESH;
    }
  }

  void _handleRefresh() {
    setState(() {
      _state = RefreshState.REFRESHING;
    });
    _animateToRefresh();
    Future<void> result = _pullDirection == PullDirection.DOWN
        ? widget.onRefresh()
        : widget.onLoadMore();
    if (result != null) {
      result.whenComplete(() {
        setState(() {
          _state = RefreshState.REFRESH_COMPLETE;
        });
        _animateToNormal();
      });
    }
  }

  Animation<double> _animation;

  void _animateToNormal() {
    if (_controller.isAnimating) {
      _controller.stop();
    }
    assert(!_controller.isAnimating);
    _animation?.removeListener(_scrollByAnimation);
    _controller.reset();
    _animation =
        _controller.drive(DoubleTween(begin: _overScrollOffset.dy, end: 0));
    _animation.addListener(_scrollByAnimation);
    _controller.forward();
  }

  void _animateToRefresh() {
    _animation?.removeListener(_scrollByAnimation);
    _controller.reset();
    _animation = _controller.drive(DoubleTween(
        begin: _overScrollOffset.dy,
        end: _pullDirection == PullDirection.DOWN
            ? _refreshExtent
            : -_refreshExtent));
    _animation.addListener(_scrollByAnimation);
    _controller.forward();
  }

  void _scrollByAnimation() {
    setState(() {
      _overScrollOffset = Offset(0, _animation.value);
      if (_overScrollOffset == Offset.zero) {
        _state = RefreshState.NORMAL;
      }
    });
  }
}

abstract class RefreshBodyBuilder {
  Widget buildTip(RefreshState state, double height);
}

class DefaultRefreshBodyBuilder implements RefreshBodyBuilder{
  final bool _isHeader;

  const DefaultRefreshBodyBuilder(this._isHeader);

  String getTintText(RefreshState state) {
    switch (state) {
      case RefreshState.NORMAL:
      case RefreshState.PULL:
        return _isHeader ? '下拉刷新' : '上拉加载';
      case RefreshState.RELEASE_TO_REFRESH:
        return _isHeader ? '释放刷新' : '释放加载';
      case RefreshState.REFRESHING:
        return _isHeader ? '刷新中' : '加载中';
      case RefreshState.REFRESH_COMPLETE:
        return _isHeader ? '刷新完成' : '加载完成';
      default:
        return _isHeader ? '下拉刷新' : '上拉加载';
        break;
    }
  }

  @override
  Widget buildTip(RefreshState state, double height) {
    return Container(
      height: height,
      color: Colors.blueGrey,
      alignment: Alignment.center,
      child: Text(getTintText(state)),
    );
  }
}