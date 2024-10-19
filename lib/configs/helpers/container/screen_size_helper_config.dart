import 'package:flutter/widgets.dart';

extension ScreenSizeHelperConfig on BuildContext {
  /// Returns a dynamic width depending on a percentage from 0-100% [width].
  double width(double percentage) {
    if (percentage <= 0.0 || percentage > 100.1) {
      throw 'percentage from 1-100%';
    }
    return MediaQuery.of(this).size.width * (percentage / 100);
  }

  /// Returns a dynamic height depending on a percentage from 0-100% [height].
  double height(double percentage) {
    if (percentage <= 0.0 || percentage > 100.1) {
      throw 'percentage from 1-100%';
    }
    return MediaQuery.of(this).size.height * (percentage / 100);
  }
}
