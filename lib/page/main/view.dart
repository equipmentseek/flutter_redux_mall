import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_mall/constant/text_styles.dart';
import 'package:flutter_redux_mall/r.dart';
import 'state.dart';
import 'action.dart';

const _tabTitles = ['首页', '分类', '购物车', '我的'];
const double _iconSize = 24.0;

Widget buildView(
  MainState state,
  Dispatch dispatch,
  ViewService viewService,
) {
  var items = List.generate(_tabTitles.length, (index){
    return BottomNavigationBarItem(
      icon: getTabIcon(index, state.tabIndex),
      title: getTabTitle(index, state.tabIndex),
    );
  });
  return Scaffold(
      body: IndexedStack(
        //使用IndexedStack为了切换的时候不重新加载已加载的页面
        children: [
          viewService.buildComponent('home'),
          viewService.buildComponent('category'),
          viewService.buildComponent('cart'),
          viewService.buildComponent('mine'),
        ],
        index: state.tabIndex,
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: items,
        type: BottomNavigationBarType.fixed,
        currentIndex: state.tabIndex,
        iconSize: _iconSize,
        onTap: (index) {
          dispatch(MainActionCreator.onTabChangeAction(index));
        },
      ));
}

///根据选择获得对应的normal或是press的icon
Image getTabIcon(int index, int tabIndex) {
  switch(index){
    case 0:
      return getTabImage(index == tabIndex ? R.imagesTabHomeSelPng : R.imagesTabHomeNorPng);
      break;
    case 1:
      return getTabImage(index == tabIndex ? R.imagesTabCategorySelPng : R.imagesTabCategoryNorPng);
      break;
    case 2:
      return getTabImage(index == tabIndex ? R.imagesTabShoppingcartSelPng : R.imagesTabShoppingcartNorPng);
      break;
    default:
      return getTabImage(index == tabIndex ? R.imagesTabMineSelPng : R.imagesTabMineNorPng);
      break;
  }
}

///获取bottomTab的颜色和文字
Text getTabTitle(int index, int tabIndex) {
  if (index == tabIndex) {
    return Text(_tabTitles[index], style: bottom_tab_sel);
  } else {
    return Text(_tabTitles[index], style: bottom_tab_nor);
  }
}

///根据image路径获取图片
Image getTabImage(path) {
  return new Image.asset(path, width: _iconSize, height: _iconSize);
}