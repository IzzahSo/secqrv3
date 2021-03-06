// ignore_for_file: file_names

import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData ? _mediaQueryData;
  static double ? screenWidth;
  static double ? screenHeight;
  static double ? defaultSize;
  static Orientation ? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    orientation = _mediaQueryData!.orientation;
    // iPhone 11 => defaultSize = 10 almost
    defaultSize = orientation == Orientation.landscape
        ? screenHeight! * 0.026
        : screenWidth! * 0.026;
  }
}
