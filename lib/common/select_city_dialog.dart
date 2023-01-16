import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jalgaon_namaz_timing/repository/api/api_repo.dart';
import 'package:jalgaon_namaz_timing/repository/local/shared_preference_repo.dart';
import 'package:jalgaon_namaz_timing/root.dart';
import 'package:jalgaon_namaz_timing/screens/home_screen/providers/home_provider.dart';
import '../screens/setting_screen/providers/setting_provider.dart';
import '../screens/start_page.dart';

class SelectCityDialog extends ConsumerWidget {
  const SelectCityDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final style = theme.textTheme;
    final model = ref.watch(settingNotifier);
    return Dialog(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Please Select Country",
            style: style.headline6,
          ),
          SelectState(
            onCountryChanged: model.onCountryChanged,
            onStateChanged: model.onStateChanged,
            onCityChanged: model.onCityChanged,
          ),
          ElevatedButton(
              onPressed: () {
                model.saveCity(() {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const Root()),
                      (route) => false);
                  ref.invalidate(sharedPreference);
                  ref.invalidate(apiRepoProvider);
                  ref.invalidate(homeNotifier);
                  ref.invalidate(selectedPageProvider);
                });
              },
              child: const Text('Select'))
        ],
      ),
    ));
  }
}
