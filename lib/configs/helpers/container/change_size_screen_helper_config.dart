import 'package:flutter/widgets.dart';

class ChangeSizeScreenHelperConfig {
  // Private constructor for singleton
  ChangeSizeScreenHelperConfig._internal();

  // Singleton instance
  static final ChangeSizeScreenHelperConfig _instance =
      ChangeSizeScreenHelperConfig._internal();

  // Factory constructor to return the singleton instance
  factory ChangeSizeScreenHelperConfig() {
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
