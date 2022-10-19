import 'package:intl/intl.dart';

String generatePrice(num value) {
  if (value == value.roundToDouble()) {
    return value.round().toString();
  }
  return generateCurrencyFormat(value as double);
}

String generateCurrencyFormat(double number) {
  final format = NumberFormat("#,##0.00", "en_US");
  return format.format(number);
}
