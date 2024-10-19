import 'package:intl/intl.dart';

class FormatterHelperConfig {
  /// [ymd] changes the format of the datetime to ymd format.
  static DateFormat ymd = DateFormat('yyyy/MM/dd');

  /// [ym] changes the format of the datetime to ym format.
  static DateFormat ym = DateFormat('yyyy/MM');

  /// [kma] changes the format of the datetime to kma format.
  static DateFormat kma = DateFormat('kk:mm\ta');

  ///[completTime] is a function that corrects a time.
  static String completTime({
    required int hour,
    required int minute,
    String divisor = ':',
    String spacer = ' ',
  }) {
    if (hour < 10 && minute < 10) {
      return '0$hour$spacer{divisor}${spacer}0$minute';
    } else if (hour < 10 && minute > 9) {
      return '0$hour$spacer$divisor$spacer$minute';
    } else if (hour > 9 && minute < 10) {
      return '$hour$spacer$divisor${spacer}0$minute';
    } else {
      return '$hour$spacer$divisor$spacer$minute';
    }
  }

  static String number(double number,
      {int decimals = 0, required String locale}) {
    final formatterNumber = NumberFormat.compactCurrency(
            decimalDigits: decimals, symbol: '', locale: locale)
        .format(number);
    return formatterNumber;
  }
}
