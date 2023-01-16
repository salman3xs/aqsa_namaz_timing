import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jalgaon_namaz_timing/repository/local/shared_preference_repo.dart';

final settingNotifier = ChangeNotifierProvider((ref) => SettingNotifier(ref));

class SettingNotifier extends ChangeNotifier {
  SettingNotifier(this.ref);
  final Ref ref;
  List<String> languageList = ['en', "ur", "hi"];
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String languageValue = "en";

  SharedPreferenceRepo get sharedPreference => ref.read(sharedPreferenceRepo);
  void onCountryChanged(value) {
    countryValue = value;
  }

  void onStateChanged(value) {
    stateValue = value;
  }

  void onCityChanged(value) {
    cityValue = value;
  }

  void saveCity(VoidCallback onDone) async {
    bool isChanged = await sharedPreference.setCity(cityValue);
    if (isChanged) {
      onDone();
    }
  }

  String getLanguageName(String lan) {
    switch (lan) {
      case 'en':
        return "English";
      case 'ur':
        return "Urdu";
      case 'hi':
        return "Hindi";
      default:
        return "English";
    }
  }

  void onLanguageChange(value) {
    languageValue = value;
    notifyListeners();
  }

  void saveLanguage(VoidCallback onDone) async {
    bool isChanged = await sharedPreference.setLanguage(languageValue);
    if (isChanged) {
      onDone();
    }
  }
}
