import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jalgaon_namaz_timing/repository/local/shared_preference_repo.dart';

final settingNotifier = ChangeNotifierProvider((ref) {
  final model = SettingNotifier(ref);
  model.init();
  return model;
});

class SettingNotifier extends ChangeNotifier {
  SettingNotifier(this.ref);
  final Ref ref;
  List<String> languageList = ['en', "ur", "hi"];

  bool _useMotion = true;
  bool get useMotion => _useMotion;
  set useMotion(bool useMotion) {
    _useMotion = useMotion;
    notifyListeners();
  }

  String _countryValue = "";
  String get countryValue => _countryValue;
  set countryValue(String countryValue) {
    _countryValue = countryValue;
    notifyListeners();
  }

  String _stateValue = "";
  String get stateValue => _stateValue;
  set stateValue(String stateValue) {
    _stateValue = stateValue;
    notifyListeners();
  }

  String _cityValue = "";
  String get cityValue => _cityValue;
  set cityValue(String cityValue) {
    _cityValue = cityValue;
    notifyListeners();
  }

  String languageValue = "en";

  SharedPreferenceRepo get sharedPreference => ref.read(sharedPreferenceRepo);

  void init() async {
    useMotion = await sharedPreference.getMotion() ?? true;
  }

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

  void changeMotion(bool value, VoidCallback onDone) async {
    useMotion = value;
    bool isChanged = await sharedPreference.setMotion(value);
    if (isChanged) {
      onDone();
    }
  }
}
