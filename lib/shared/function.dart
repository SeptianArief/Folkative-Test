import 'package:intl/intl.dart';

//merubah double menjadi currency format
String moneyChanger(double value, {String? customLabel}) {
  return NumberFormat.currency(
          name: customLabel ?? 'Rp', decimalDigits: 0, locale: 'id')
      .format(value.round());
}
