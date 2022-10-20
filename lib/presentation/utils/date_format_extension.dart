
import 'package:intl/intl.dart';

DateTime getDateFromString(String date) {
  return DateTime.parse(date);
}

String generateDateFormat(DateTime date) {
  return DateFormat.yMd().add_Hm().format(date);
}