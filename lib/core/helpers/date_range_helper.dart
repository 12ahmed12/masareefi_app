import 'package:flutter/material.dart';

class DateRangeUtils {
  static DateTimeRange getRange(String filter) {
    final now = DateTime.now();

    switch (filter) {
      case 'آخر 7 أيام':
        return DateTimeRange(
            start: now.subtract(const Duration(days: 7)), end: now);
      case 'آخر 30 يوم':
        return DateTimeRange(
            start: now.subtract(const Duration(days: 30)), end: now);
      case 'هذا العام':
        return DateTimeRange(start: DateTime(now.year, 1, 1), end: now);
      default:
        return DateTimeRange(
            start: DateTime(now.year, now.month), end: now); // هذا الشهر
    }
  }
}
