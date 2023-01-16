import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jalgaon_namaz_timing/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreference =
    FutureProvider((ref) => SharedPreferenceRepo().getData());

final sharedPreferenceRepo = Provider((ref) => SharedPreferenceRepo());

class SharedPreferenceRepo {
  SharedPreferences? prefs;

  Future<SharedPreferences?> getData() async {
    prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  Future<void> checkData() async {
    if (prefs == null) {
      await getData();
    } else {
      return;
    }
  }

  Future<String?> getCity() async {
    await checkData();
    if (prefs != null) {
      return prefs!.getString(PrefKeys.city);
    } else {
      return null;
    }
  }

  Future<bool> setCity(String city) async {
    await checkData();
    if (prefs != null) {
      return await prefs!.setString(PrefKeys.city, city);
    } else {
      return false;
    }
  }

  Future<String?> getLanguage() async {
    await checkData();
    if (prefs != null) {
      return prefs!.getString(PrefKeys.language);
    } else {
      return null;
    }
  }

  Future<bool> setLanguage(String language) async {
    await checkData();
    if (prefs != null) {
      return await prefs!.setString(PrefKeys.language, language);
    } else {
      return false;
    }
  }
}
