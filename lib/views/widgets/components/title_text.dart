import 'package:flutter/material.dart';
import 'SizeConfig.dart';
class TitleText extends StatelessWidget {
  const TitleText({
    Key ? key, this.title, 
  }) : super(key: key);

  final String ? title;

  @override
  Widget build(BuildContext context) {
    var defaultSize = SizeConfig.defaultSize;
    return Text(
      title!,
      style: TextStyle(
        fontSize: defaultSize!*2.0, 
        fontWeight: FontWeight.bold,
      ),
    );
  }
}