import 'package:intl/intl.dart';

String formatWonNumber(int number) {
  final formatter = NumberFormat('#,###', 'en_US');
  return formatter.format(number);
}