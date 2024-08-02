import 'package:intl/intl.dart';

extension DateUtils on DateTime {
  String get toFormattedString {
    DateFormat dateFormat = DateFormat('dd MM yyyy', Intl.defaultLocale);
    return dateFormat.format(this);
  }
}