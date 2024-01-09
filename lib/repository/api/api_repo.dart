// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '/models/daily_time_model.dart';

import '../local/shared_preference_repo.dart';

final apiRepoProvider = FutureProvider((ref) => ApiRepo(ref).getDailyTime());

class ApiRepo {
  final Ref ref;
  ApiRepo(this.ref);

  SharedPreferenceRepo get sharedPreference => ref.read(sharedPreferenceRepo);

  Future<List<DailyTimeModel>?> getDailyTime() async {
    String? city = await sharedPreference.getCity();
    if (city != null) {
      final req = await http.get(Uri.parse(
          'http://api.aladhan.com/v1/calendarByCity?city=$city&country=india&school=1'));
      final List data = json.decode(req.body)['data'];
      return data.map((e) => DailyTimeModel.fromMap(e)).toList();
    } else {
      return null;
    }
  }
}
