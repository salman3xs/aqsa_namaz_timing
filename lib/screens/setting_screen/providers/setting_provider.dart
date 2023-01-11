import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jalgaon_namaz_timing/repository/local/shared_preference_repo.dart';

final settingNotifier = ChangeNotifierProvider((ref) => SettingNotifier(ref));

class SettingNotifier extends ChangeNotifier {
  SettingNotifier(this.ref);
  final Ref ref;
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";

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
}
