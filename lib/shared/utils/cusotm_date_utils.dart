import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateUtils {
  /// [TimeofDay] to String
  static String formatTimeOfDay(TimeOfDay timeOfDay, BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    return localizations.formatTimeOfDay(timeOfDay,
        alwaysUse24HourFormat: false);
  }

  /// [DateTime] into String as Septemeber 12, 2021
  static String formatDate(DateTime dateTime) {
    // Define the format pattern as 'MMM d, yyyy'
    final DateFormat formatter = DateFormat('MMM d, yyyy');
    return formatter.format(dateTime);
  }

  /// [DateTime] into String as Septemeber 12, 2021
  static String formatDateFilter(DateTime dateTime) {
    // Define the format pattern as 'MMM d, yyyy'
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }

  static TimeOfDay stringToTimeOfDay(String timeString) {
    // Example input: "10:00 PM"
    final format =
        timeString.split(RegExp(r'[:\s]')); // Split by colon and space
    int hour = int.parse(format[0]);
    int minute = int.parse(format[1]);
    String period = format[2].toUpperCase(); // "AM" or "PM"

    // Convert 12-hour format to 24-hour format
    if (period == "PM" && hour != 12) {
      hour += 12;
    } else if (period == "AM" && hour == 12) {
      hour = 0; // Midnight case
    }

    return TimeOfDay(hour: hour, minute: minute);
  }

  static String convertTo24HourFormat(String timeString) {
    final DateFormat inputFormat =
        DateFormat('h:mm a'); // Handle both leading zeros and 12-hour format
    final DateFormat outputFormat = DateFormat.Hm(); // Convert to 'HH:mm'

    try {
      final DateTime parsedTime = inputFormat.parse(timeString);
      return outputFormat.format(parsedTime); // Return 'HH:mm' format
    } catch (e) {
      return 'Invalid time format';
    }
  }

  static  String convertTo12HourFormat(String? timeString) {
  if (timeString == null || timeString.isEmpty) return 'Invalid time format';

  final DateFormat inputFormat = DateFormat('HH:mm:ss'); // For parsing 24-hour format with seconds
  final DateFormat outputFormat = DateFormat('h:mm a'); // Convert to 12-hour format with AM/PM

  try {
    final DateTime parsedTime = inputFormat.parse(timeString);
    return outputFormat.format(parsedTime); // Output as 'h:mm a'
  } catch (e) {
    return 'Invalid time format';
  }
}

  static bool isFirstTimeAfter(TimeOfDay first, TimeOfDay second) {
    final firstMinutes = first.hour * 60 + first.minute;
    final secondMinutes = second.hour * 60 + second.minute;

    return firstMinutes > secondMinutes;
  }
}
