import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/select_city_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              onPressed: () {},
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
