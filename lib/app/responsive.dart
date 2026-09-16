import 'package:flutter/material.dart';

class Responsive {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;

    final safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    final safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;

    blockSizeHorizontal = (screenWidth - safeAreaHorizontal) / 100;
    blockSizeVertical = (screenHeight - safeAreaVertical) / 100;
    safeBlockHorizontal = (screenWidth - safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - safeAreaVertical) / 100;
  }

  static double width(double percentage) {
    return screenWidth * percentage / 100;
  }

  static double height(double percentage) {
    return screenHeight * percentage / 100;
  }

  static double font(double value) {
    final base = screenWidth < 360 ? 0.9 : 1.0;
    return value * base;
  }

  static double radius(double value) {
    return value;
  }

  static bool get isMobilePortrait => screenWidth < 600;
  static bool get isTablet => screenWidth >= 600 && screenWidth < 1100;
  static bool get isDesktop => screenWidth >= 1100;
}
