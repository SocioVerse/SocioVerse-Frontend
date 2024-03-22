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

  static String getTimeDiff(DateTime dateTime) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);
    int secondsAgo = difference.inSeconds;
    if (secondsAgo < 60) {
      return 'just now';
    }

    int minutesAgo = difference.inMinutes;
    if (minutesAgo < 60) {
      return '$minutesAgo min';
    }

    int hoursAgo = difference.inHours;
    if (hoursAgo == 1) {
      return '1 hr';
    } else if (hoursAgo < 24) {
      return '$hoursAgo hrs';
    }

    int daysAgo = difference.inDays;
    return '$daysAgo days';
  }

  static bool isStrongPassword(String password) {
    RegExp passwordPattern = RegExp(
      r'^(?=.*[A-Z])' // At least one uppercase letter
      r'(?=.*[a-z])' // At least one lowercase letter
      r'(?=.*?[0-9])' // At least one digit
      r'.{8,}$', // At least 8 characters long
    );

    return passwordPattern.hasMatch(password);
  }

  static bool isEmailValid(String email) {
    RegExp emailPattern = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      caseSensitive: false,
      multiLine: false,
    );

    // Check if the email matches the pattern
    return emailPattern.hasMatch(email);
  }

  static String getDay(DateTime dateTime) {
    DateTime now = DateTime.now().toLocal();

    if (now.year == dateTime.year &&
        now.month == dateTime.month &&
        now.day == dateTime.day) {
      return 'Today';
    } else if (now.subtract(const Duration(days: 1)).year == dateTime.year &&
        now.subtract(const Duration(days: 1)).month == dateTime.month &&
        now.subtract(const Duration(days: 1)).day == dateTime.day) {
      return 'Yesterday';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }

  static String getTime(DateTime dateTime) {
    // AM Pm
    String amPm = dateTime.hour >= 12 ? 'PM' : 'AM';
    // hour
    int hour = dateTime.hour % 12;
    if (hour == 0) {
      hour = 12;
    }
    // minute
    String minute = dateTime.minute.toString();
    if (minute.length == 1) {
      minute = '0$minute';
    }
    return '$hour:$minute $amPm';
  }

  static String numberToMkConverter(double number) {
    if (number >= 1000000) {
      double result = number / 1000000;
      return '${result.toStringAsFixed(0)}M';
    } else if (number >= 1000) {
      double result = number / 1000;
      return '${result.toStringAsFixed(0)}K';
    } else {
      return number.toString();
    }
  }
}
