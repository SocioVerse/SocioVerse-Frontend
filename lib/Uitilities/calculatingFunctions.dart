class CalculatingFunction {
  static String numberToBMKonverter(double number) {
    if (number >= 1e9) {
      double billions = number / 1e9;
      if (billions.floor() == billions) {
        return "${billions.toInt()}B";
      } else {
        return "${billions.toStringAsFixed(1)}B";
      }
    } else if (number >= 1e6) {
      double millions = number / 1e6;
      if (millions.floor() == millions) {
        return "${millions.toInt()}M";
      } else {
        return "${millions.toStringAsFixed(1)}M";
      }
    } else if (number >= 1e3) {
      double thousands = number / 1e3;
      if (thousands.floor() == thousands) {
        return "${thousands.toInt()}K";
      } else {
        return "${thousands.toStringAsFixed(1)}K";
      }
    } else {
      return number.toStringAsFixed(2);
    }
  }
}
