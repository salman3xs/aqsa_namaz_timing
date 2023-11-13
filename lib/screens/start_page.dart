import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jalgaon_namaz_timing/Screens/home_screen/home_page.dart';
import 'package:jalgaon_namaz_timing/screens/qiblah_screen/qiblah_page.dart';
import 'package:jalgaon_namaz_timing/screens/setting_screen/setting_page.dart';
import 'package:jalgaon_namaz_timing/utils/app_colors.dart';

final selectedPageProvider = StateProvider<int>((ref) {
  return 0;
});

class StartPage extends ConsumerWidget {
  const StartPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pg = ref.watch(selectedPageProvider);
    return Scaffold(
      appBar: pg > 0
          ? AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              title: Text(AppLocalizations.of(context)!.jalgaonNamazTiming),
            )
          : null,
      // backgroundColor: Theme.of(context).primaryColor,
      body: [
        const HomePage(),
        QiblahPage(),
        const SettingPage(),
      ][pg],
      bottomNavigationBar: CurvedNavigationBar(
        // color: Theme.of(context).primaryColor,
        index: pg,
        buttonBackgroundColor: Colors.white,
        backgroundColor: AppColors.ans!,
        items: [
          Icon(
            Icons.home,
            size: 30,
            color: AppColors.ans,
          ),
          Icon(
            Icons.not_listed_location,
            size: 30,
            color: AppColors.ans,
          ),
          Icon(
            Icons.settings,
            size: 30,
            color: AppColors.ans,
          ),
        ],
        onTap: (index) {
          ref.read(selectedPageProvider.notifier).state = index;
        },
      ),
    );
  }
}
