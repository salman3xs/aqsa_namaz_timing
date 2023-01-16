import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jalgaon_namaz_timing/extension/time_of_day_extensions.dart';
import 'package:jalgaon_namaz_timing/repository/local/shared_preference_repo.dart';
import '../../../models/daily_time_model.dart';

final homeNotifier = ChangeNotifierProvider((ref) {
  final model = HomeProvider(ref);
  model.getCity();
  return model;
});

class HomeProvider extends ChangeNotifier {
  final Ref ref;
  HomeProvider(this.ref);

  String? _city;
  String? get city => _city;
  set city(String? city) {
    _city = city;
    notifyListeners();
  }

  SharedPreferenceRepo get _sharedPreferenceRepo =>
      ref.read(sharedPreferenceRepo);

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
    startTime.add(dailyTimeModel.fajr);//fajr
    startTime.add(dailyTimeModel.dhuhr);//dhuhr
    startTime.add(dailyTimeModel.asr);//asr
    startTime.add(dailyTimeModel.magrib);//magrib
    startTime.add(dailyTimeModel.isha);//isha
    startTime.add(dailyTimeModel.fajr);//sahri
    startTime.add(dailyTimeModel.magrib);//iftar
    startTime.add(dailyTimeModel.sunRise);//tulu
    startTime.add(dailyTimeModel.dhuhr.subTime(10));//zawal
    startTime.add(dailyTimeModel.magrib.subTime(3));//gurub
    startTime.add(dailyTimeModel.sunRise);//ishrq
    startTime.add(dailyTimeModel.sunRise);//chast
    endTime.clear();
    endTime.add(dailyTimeModel.sunRise);//fajr
    endTime.add(dailyTimeModel.asr);//dhuhr
    endTime.add(dailyTimeModel.magrib.subTime(3));//asr
    endTime.add(dailyTimeModel.isha);//magrib
    endTime.add(dailyTimeModel.fajr);//isha
    endTime.add(dailyTimeModel.fajr);//sahri
    endTime.add(dailyTimeModel.magrib);//iftar
    endTime.add(dailyTimeModel.sunRise.addTime(20));//tulu
    endTime.add(dailyTimeModel.dhuhr);//zawal
    endTime.add(dailyTimeModel.magrib);//gurub
    endTime.add(dailyTimeModel.sunRise);//ishrq
    endTime.add(dailyTimeModel.sunRise);//chast
  }

  void getCity() async {
    city = await _sharedPreferenceRepo.getCity();
  }
}
