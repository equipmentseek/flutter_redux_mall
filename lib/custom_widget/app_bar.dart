import 'package:flutter/material.dart';
import 'package:flutter_redux_mall/constant/colors.dart';
import 'package:flutter_redux_mall/constant/text_styles.dart';
import 'package:flutter_redux_mall/r.dart';

/// 自定义的TitleBar
class TitleBar extends StatelessWidget implements PreferredSizeWidget {
  final String _title;
  final String subtitle;
  final String menuIconPath;
  VoidCallback leadingOnPress;
  final VoidCallback subTitleOnPress;

  TitleBar(
    this._title, {
    this.subTitleOnPress,
    this.leadingOnPress,
    this.subtitle = '',
    this.menuIconPath = '',
  });

  @override
  Widget build(BuildContext context) {
    if (leadingOnPress == null) {
      leadingOnPress = () {
        Navigator.pop(context);
      };
    }
    return DecoratedBox(
      child: SafeArea(
        child: SizedBox.fromSize(
          size: Size.fromHeight(48.0),
          child: Row(
            children: <Widget>[
              IconButton(
                  icon: ImageIcon(AssetImage(R.imagesBackPng)),
                  onPressed: leadingOnPress),
              Expanded(
                  child: Center(
                      child: Text(
                _title,
                style: c333_16,
              ))),
              getSubTitle(),
            ],
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: white,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(48.0);

  Widget getSubTitle() {
    Widget subWidget;
    if (menuIconPath.isNotEmpty) {
      subWidget = IconButton(
          icon: ImageIcon(AssetImage(menuIconPath)),
          onPressed: subTitleOnPress);
    } else {
      subWidget = GestureDetector(
        child: Text(subtitle, style: c333_14),
        onTap: subTitleOnPress,
      );
    }
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: subWidget,
    );
  }
}
