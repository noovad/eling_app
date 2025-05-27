import 'package:intl/intl.dart';

class DateConstants {
  static String formatToYYYYMMDD(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  static String get todayStr => formatToYYYYMMDD(DateTime.now());

  static String get yesterdayStr =>
      formatToYYYYMMDD(DateTime.now().subtract(const Duration(days: 1)));

  static String get tomorrowStr =>
      formatToYYYYMMDD(DateTime.now().add(const Duration(days: 1)));

  static String formatToReadable(DateTime date) {
    final DateFormat formatter = DateFormat('MMM dd, yyyy');
    return formatter.format(date);
  }

  static String formatToShortDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }

  static DateTime parseFromYYYYMMDD(String dateStr) {
    final parts = dateStr.split('-');
    if (parts.length != 3) {
      throw FormatException('Invalid date format. Expected YYYY-MM-DD.');
    }

    final year = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final day = int.parse(parts[2]);

    return DateTime(year, month, day);
  }

  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  static bool isPast(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final compareDate = DateTime(date.year, date.month, date.day);
    return compareDate.isBefore(today);
  }

  static bool isFuture(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final compareDate = DateTime(date.year, date.month, date.day);
    return compareDate.isAfter(today);
  }
}
