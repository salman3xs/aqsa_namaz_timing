// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class DailyTimeModel {
  final TimeOfDay fajr;
  final TimeOfDay sunRise;
  final TimeOfDay dhuhr;
  final TimeOfDay asr;
  final TimeOfDay sunSet;
  final TimeOfDay magrib;
  final TimeOfDay isha;
  final String readable;
  final DateTime timestamp;
  final String date;
  final int day;
  final String weekday;
  final String hijriDate;
  final String hijriMonth;
  DailyTimeModel({
    required this.fajr,
    required this.sunRise,
    required this.dhuhr,
    required this.asr,
    required this.sunSet,
    required this.magrib,
    required this.isha,
    required this.readable,
    required this.timestamp,
    required this.date,
    required this.day,
    required this.weekday,
    required this.hijriDate,
    required this.hijriMonth
  });

  DailyTimeModel copyWith({
    TimeOfDay? fajr,
    TimeOfDay? sunRise,
    TimeOfDay? dhuhr,
    TimeOfDay? asr,
    TimeOfDay? sunSet,
    TimeOfDay? magrib,
    TimeOfDay? isha,
    String? readable,
    DateTime? timestamp,
    String? date,
    int? day,
    String? weekday,
    String? hijriDate,
    String? hijriMonth,
  }) {
    return DailyTimeModel(
      fajr: fajr ?? this.fajr,
      sunRise: sunRise ?? this.sunRise,
      dhuhr: dhuhr ?? this.dhuhr,
      asr: asr ?? this.asr,
      sunSet: sunSet ?? this.sunSet,
      magrib: magrib ?? this.magrib,
      isha: isha ?? this.isha,
      readable: readable ?? this.readable,
      timestamp: timestamp ?? this.timestamp,
      date: date ?? this.date,
      day: day ?? this.day,
      weekday: weekday ?? this.weekday,
      hijriDate: hijriDate ?? this.hijriDate,
      hijriMonth: hijriMonth ?? this.hijriMonth,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fajr': fajr,
      'sunRise': sunRise,
      'dhuhr': dhuhr,
      'asr': asr,
      'sunSet': sunSet,
      'magrib': magrib,
      'isha': isha,
      'readable': readable,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'date': date,
      'day': day,
      'weekday': weekday,
      'hijriDate': hijriDate,
      'hijriMonth':hijriMonth
    };
  }

  factory DailyTimeModel.fromMap(Map<String, dynamic> map) {
    return DailyTimeModel(
      fajr: stringToTime(map['timings']['Fajr']),
      sunRise: stringToTime(map['timings']['Sunrise']),
      dhuhr: stringToTime(map['timings']['Dhuhr'] as String),
      asr: stringToTime(map['timings']['Asr'] as String),
      sunSet: stringToTime(map['timings']['Sunset'] as String),
      magrib: stringToTime(map['timings']['Maghrib'] as String),
      isha: stringToTime(map['timings']['Isha'] as String),
      readable: map['date']['readable'] as String,
      timestamp: DateTime.fromMillisecondsSinceEpoch(
          int.parse(map['date']['timestamp'])),
      date: map['date']['gregorian']['date'] as String,
      day: int.parse(map['date']['gregorian']['day']),
      weekday: map['date']['gregorian']['weekday']['en'] as String,
      hijriDate: map['date']['hijri']['date'] as String,
      hijriMonth: map['date']['hijri']['month']['en'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DailyTimeModel.fromJson(String source) =>
      DailyTimeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory DailyTimeModel.fromApiResponse(Response req) {
    print(json.decode(req.body)['data'].length);
    return DailyTimeModel.fromMap(json.decode(req.body)['data'][0]);
  }

  @override
  String toString() {
    return 'DailyTimeModel(fajr: $fajr, sunRise: $sunRise, dhuhr: $dhuhr, asr: $asr, sunSet: $sunSet, magrib: $magrib, isha: $isha, readable: $readable, timestamp: $timestamp, date: $date, day: $day, weekday: $weekday, hijriDate: $hijriDate)';
  }

  @override
  bool operator ==(covariant DailyTimeModel other) {
    if (identical(this, other)) return true;

    return other.fajr == fajr &&
        other.sunRise == sunRise &&
        other.dhuhr == dhuhr &&
        other.asr == asr &&
        other.sunSet == sunSet &&
        other.magrib == magrib &&
        other.isha == isha &&
        other.readable == readable &&
        other.timestamp == timestamp &&
        other.date == date &&
        other.day == day &&
        other.weekday == weekday &&
        other.hijriDate == hijriDate;
  }

  @override
  int get hashCode {
    return fajr.hashCode ^
        sunRise.hashCode ^
        dhuhr.hashCode ^
        asr.hashCode ^
        sunSet.hashCode ^
        magrib.hashCode ^
        isha.hashCode ^
        readable.hashCode ^
        timestamp.hashCode ^
        date.hashCode ^
        day.hashCode ^
        weekday.hashCode ^
        hijriDate.hashCode;
  }
}

TimeOfDay stringToTime(String time) {
  return TimeOfDay(
      hour: int.parse(time[0] + time[1]), minute: int.parse(time[3] + time[4]));
}
