import 'package:get/get.dart';
import 'package:intl/intl.dart';

String dateFormat(DateTime dateTime) {
  final formatter = DateFormat("yy-MM-dd\nHH:mm");
  return formatter.format(dateTime);
}
