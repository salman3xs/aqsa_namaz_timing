import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jalgaon_namaz_timing/repository/api/api_repo.dart';
import 'package:jalgaon_namaz_timing/repository/local/shared_preference_repo.dart';
import 'package:jalgaon_namaz_timing/root.dart';
import '../screens/setting_screen/providers/setting_provider.dart';
import '../screens/start_page.dart';

class SelectLanguageDialog extends ConsumerWidget {
  const SelectLanguageDialog({
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
            "Please Select Language",
            style: style.headline6,
          ),
          DropdownButton(
              value: model.languageValue,
              items: model.languageList
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(model.getLanguageName(e)),
                      ))
                  .toList(),
              onChanged: model.onLanguageChange),
          ElevatedButton(
              onPressed: () {
                model.saveLanguage(() {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const Root()),
                      (route) => false);
                  ref.invalidate(sharedPreference);
                  ref.invalidate(apiRepoProvider);
                  ref.invalidate(selectedPageProvider);
                });
              },
              child: const Text('Select'))
        ],
      ),
    ));
  }
}
