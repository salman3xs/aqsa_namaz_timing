import 'package:flutter/material.dart';

class AppColors {

 static bool isDay = true;
 static bool isDusk = true;
 static int currentHour = DateTime.now().hour;
 static Color? ans = Colors.blue[200];

 static void init() {
      isDay = currentHour >= 6 && currentHour <= 18;
      isDusk = currentHour >= 16 && currentHour <= 18;
      if (!isDay) {
        ans = Colors.blueGrey[900];
      } else if (isDusk) {
        ans = Colors.orange[400];
      } else {
        ans = Colors.blue[200];
      }
  }
}
