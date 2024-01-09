import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/repository/api/api_repo.dart';
import '/repository/local/shared_preference_repo.dart';
import '/root.dart';
import '/screens/home_screen/providers/home_provider.dart';
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
          CSCPicker(
            layout: Layout.vertical,
            currentCountry:
                model.countryValue != '' ? model.countryValue : null,
            currentState: model.stateValue != '' ? model.stateValue : null,
            currentCity: model.cityValue != '' ? model.cityValue : null,
            onCountryChanged: (value) {
              model.countryValue = value.split(' ').last;
            },
            onStateChanged: (value) {
              if (value != null) {
                model.stateValue = value;
              }
            },
            onCityChanged: (value) {
              if (value != null) {
                model.cityValue = value;
              }
            },
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
