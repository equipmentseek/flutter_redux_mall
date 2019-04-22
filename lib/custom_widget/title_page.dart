import 'package:flutter/material.dart';
import 'app_bar.dart';

class TitlePageWidget extends StatelessWidget {
  final String title;
  final Widget body;
  final String subtitle;
  final String menuIconPath;
  final VoidCallback leadingOnPress;
  final VoidCallback subTitleOnPress;

  TitlePageWidget({
    @required this.title,
    @required this.body,
    this.subTitleOnPress,
    this.leadingOnPress,
    this.subtitle = '',
    this.menuIconPath = '',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar(
        title: title,
        subtitle: subtitle,
        leadingOnPress: leadingOnPress,
        menuIconPath: menuIconPath,
        subTitleOnPress: subTitleOnPress,
      ),
      body: body,
    );
  }
}
