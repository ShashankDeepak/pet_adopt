import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  DateFormat format = DateFormat("dd/MM/yyyy");
  return format.format(date);
}
