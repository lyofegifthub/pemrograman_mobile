
import 'package:intl/intl.dart';

class CurrencyFormatter {
  static final NumberFormat _rupiah = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  static String format(num price) {
    return _rupiah.format(price);
  }
}
