import 'package:flutter/widgets.dart';

class ChangeSizeScreenHelper {
  // Private constructor for singleton
  ChangeSizeScreenHelper._internal();

  // Singleton instance
  static final ChangeSizeScreenHelper _instance =
      ChangeSizeScreenHelper._internal();

  // Factory constructor to return the singleton instance
  factory ChangeSizeScreenHelper() {
    return _instance;
  }

  // Access MediaQueryData using BuildContext
  MediaQueryData _mediaQueryData(BuildContext context) {
    return MediaQuery.of(context);
  }

  double getScreenWidth(BuildContext context) {
    return _mediaQueryData(context).size.width;
  }

  double getScreenHeight(BuildContext context) {
    return _mediaQueryData(context).size.height;
  }

  bool isSmallScreen(BuildContext context) {
    return getScreenWidth(context) < 700;
  }

  bool isMediumScreen(BuildContext context) {
    return getScreenWidth(context) >= 700 && getScreenWidth(context) <= 1150;
  }

  bool isLargeScreen(BuildContext context) {
    return getScreenWidth(context) > 1150;
  }
}
