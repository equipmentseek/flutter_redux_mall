import 'package:flutter/material.dart';
import 'package:flutter_redux_mall/constant/colors.dart';
import 'package:flutter_redux_mall/constant/text_styles.dart';
import 'package:flutter_redux_mall/r.dart';

/// 自定义的TitleBar
class TitleBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final String menuIconPath;
  final VoidCallback leadingOnPress;
  final VoidCallback subTitleOnPress;

  TitleBar({
    @required this.title,
    this.subTitleOnPress,
    this.leadingOnPress,
    this.subtitle = '',
    this.menuIconPath = '',
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      child: SafeArea(
        child: SizedBox.fromSize(
          size: Size.fromHeight(51),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                    icon: ImageIcon(AssetImage(R.imagesBackPng)),
                    onPressed: () {
                      if (leadingOnPress != null) {
                        leadingOnPress();
                      } else {
                        Navigator.pop(context);
                      }
                    }),
              ),
              Align(
                alignment: Alignment.center,
                child: Center(
                    child: Text(
                  title,
                  style: c333_16,
                )),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: getSubTitle(),
              ),
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
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(subtitle, style: c333_14),
        ),
        onTap: subTitleOnPress,
      );
    }
    return subWidget;
  }
}
