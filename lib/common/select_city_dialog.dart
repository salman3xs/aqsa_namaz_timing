import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jalgaon_namaz_timing/repository/api/api_repo.dart';
import '../screens/setting_screen/providers/setting_provider.dart';

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
            // style: TextStyle(color: Colors.red),
            onCountryChanged: model.onCountryChanged,
            onStateChanged: model.onStateChanged,
            onCityChanged: model.onCityChanged,
          ),
          ElevatedButton(
              onPressed: () {
                model.saveCity(() {
                  // ignore: unused_result
                  ref.refresh(apiRepoProvider);
                });
              },
              child: Text('Select'))
        ],
      ),
    ));
  }
}
