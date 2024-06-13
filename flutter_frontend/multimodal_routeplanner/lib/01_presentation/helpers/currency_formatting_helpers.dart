import 'package:intl/intl.dart';

String formatCurrency(double value) {
  final NumberFormat format = NumberFormat.currency(locale: 'de_DE', symbol: '€', decimalDigits: 2);
  return format.format(value);
}
