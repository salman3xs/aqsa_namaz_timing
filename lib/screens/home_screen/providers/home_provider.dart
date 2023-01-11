import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jalgaon_namaz_timing/extension/time_of_day_extensions.dart';
import '../../../models/daily_time_model.dart';

final homeNotifier = ChangeNotifierProvider((ref) => HomeProvider());

class HomeProvider extends ChangeNotifier {
  final List<String> entries = <String>[
    'Fajr',
    'Zuhar',
    'Asr',
    'Maghrib',
    'Isha',
    'Sahri',
    'Iftar',
    'Tulu E Aftab',
    'Zawal',
    'Gurub E Aftab',
    'Ishraq',
    'Chasht',
  ];
  final List<Color> clr = <Color>[
    Colors.greenAccent,
    Colors.greenAccent,
    Colors.greenAccent,
    Colors.greenAccent,
    Colors.greenAccent,
    Colors.lightBlueAccent,
    Colors.lightBlueAccent,
    Colors.redAccent,
    Colors.redAccent,
    Colors.redAccent,
    Colors.lightBlueAccent,
    Colors.lightBlueAccent,
  ];
  List<TimeOfDay> startTime = [];
  List<TimeOfDay> endTime = [];

  void addTimings(DailyTimeModel dailyTimeModel) {
    startTime.clear();
    startTime.add(dailyTimeModel.fajr);
    startTime.add(dailyTimeModel.dhuhr);
    startTime.add(dailyTimeModel.asr);
    startTime.add(dailyTimeModel.magrib);
    startTime.add(dailyTimeModel.isha);
    startTime.add(dailyTimeModel.fajr);
    startTime.add(dailyTimeModel.magrib);
    startTime.add(dailyTimeModel.sunRise);
    startTime.add(dailyTimeModel.dhuhr);
    startTime.add(dailyTimeModel.magrib);
    startTime.add(dailyTimeModel.sunRise);
    startTime.add(dailyTimeModel.sunRise);
    startTime.add(dailyTimeModel.sunRise);
    endTime.clear();
    endTime.add(dailyTimeModel.sunRise);
    endTime.add(dailyTimeModel.asr);
    endTime.add(dailyTimeModel.magrib.subTime(3));
    endTime.add(dailyTimeModel.isha);
    endTime.add(dailyTimeModel.fajr);
    endTime.add(dailyTimeModel.magrib);
    endTime.add(dailyTimeModel.sunRise);
    endTime.add(dailyTimeModel.dhuhr);
    endTime.add(dailyTimeModel.magrib);
    endTime.add(dailyTimeModel.sunRise);
    endTime.add(dailyTimeModel.sunRise);
    endTime.add(dailyTimeModel.sunRise);
  }
}
