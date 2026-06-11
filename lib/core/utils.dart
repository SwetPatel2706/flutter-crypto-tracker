import 'package:intl/intl.dart';

class AppUtils {
  static String formatPrice(double price) {
    // Adds commas and keeps 2 decimals (e.g., "$42,305.00")
    return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(price);
  }

  static String formatVolume(double volume) {
    // Compact format for huge numbers (e.g., "$1.2B")
    return NumberFormat.compactCurrency(symbol: '\$').format(volume);
  }
}