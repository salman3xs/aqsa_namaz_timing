import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jalgaon_namaz_timing/Screens/start_page.dart';

void main() async {
  runApp(ProviderScope(child: Home()));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Jalgaon Namaz Timing",
      theme: ThemeData(
        primaryColor: getColor(),
      ),
      home: StartPage(),
    );
  }

  ThemeData getCurrentTheme() {
    TimeOfDay timeOfDay = TimeOfDay.now();
    if (timeOfDay.hour < 6 || timeOfDay.hour >= 18) {
      return ThemeData.dark();
    }
    return ThemeData.light();
  }

  Color? getColor() {
    final timeState = DateTime.now();
    final hour = timeState.hour;
    final isDay = hour >= 6 && hour <= 18;
    final isDusk = hour >= 16 && hour <= 18;
    if (!isDay) {
      return Colors.blueGrey[900];
    }
    if (isDusk) {
      return Colors.orange[400];
    }
    return Colors.blue[200];
  }
}
