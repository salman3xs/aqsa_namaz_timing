import 'package:flutter/material.dart';

extension DisplayString on TimeOfDay {
  String asString() {
    return "$hourOfPeriod:$minute ${period.name}";
  }

  int compareTo(TimeOfDay other) {
    if (hour < other.hour) return -1;
    if (hour > other.hour) return 1;
    if (minute < other.minute) return -1;
    if (minute > other.minute) return 1;
    return 0;
  }

  TimeOfDay addTime(int min) {
    int total = minute + min;

    if (total > 60) {
      return TimeOfDay(hour: hour + 1, minute: total - 60);
    } else {
      return TimeOfDay(hour: hour, minute: total);
    }
  }

  TimeOfDay subTime(int min) {
    int total = minute - min;
    if (total.isNegative) {
      return TimeOfDay(hour: hour - 1, minute: total + 60);
    } else {
      return TimeOfDay(hour: hour, minute: total);
    }
  }

  Duration difference(TimeOfDay other) {
    int diffHour = hour - other.hour;
    int diffMin = minute - other.minute;
    if (diffMin.isNegative) {
      if (diffHour == 0) {
        return Duration(hours: diffHour, minutes: diffMin + 60);
      }
      return Duration(hours: diffHour - 1, minutes: diffMin + 60);
    }
    return Duration(hours: diffHour, minutes: diffMin);
  }
}
