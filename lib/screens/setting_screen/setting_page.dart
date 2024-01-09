import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/common/select_language_dailog.dart';
import '/screens/home_screen/providers/home_provider.dart';
import '/screens/setting_screen/providers/setting_provider.dart';
import '/screens/setting_screen/widgets/about_dialog.dart';
import '../../common/select_city_dialog.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(settingNotifier);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.setting,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.white),
          ),
          const SizedBox(height: 15),
          TextButton(
              onPressed: () {
                showDialog(
                    context: context, builder: (_) => const SelectCityDialog());
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: Text(
                AppLocalizations.of(context)!.changeCity,
                style: const TextStyle(color: Colors.black),
              )),
          const SizedBox(height: 15),
          TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) => const SelectLanguageDialog());
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: Text(
                AppLocalizations.of(context)!.changeLanguage,
                style: const TextStyle(color: Colors.black),
              )),
          const SizedBox(height: 15),
          Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              title: const Text(
                'Motion Effect on Homepage',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              trailing: Switch(
                value: model.useMotion,
                onChanged: (v) {
                  model.changeMotion(v, () {
                    ref.invalidate(homeNotifier);
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 15),
          TextButton(
              onPressed: () {
                showDialog(context: context, builder: (_) => const AboutPage());
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: Text(
                AppLocalizations.of(context)!.about,
                style: const TextStyle(color: Colors.black),
              ))
        ],
      ),
    );
  }
}
