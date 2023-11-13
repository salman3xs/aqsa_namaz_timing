import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jalgaon_namaz_timing/extension/time_of_day_extensions.dart';
import 'package:jalgaon_namaz_timing/screens/home_screen/providers/home_provider.dart';
import 'package:motion/motion.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../../repository/api/api_repo.dart';
import 'day_night_banner.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(homeNotifier);
    return model.motion == null || model.motion!
        ? const Motion(child: Home())
        : const Home();
  }
}

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final api = ref.watch(apiRepoProvider);
    final model = ref.watch(homeNotifier);
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        children: [
          const Expanded(
            flex: 1,
            child: SizedBox(
              width: double.infinity,
              child: DayNightBanner(),
            ),
          ),
          Expanded(
              flex: 3,
              child: api.when(
                  data: (data) {
                    if (data != null) {
                      final index = DateTime.now().day;
                      final dailyTimeModel = data[index];
                      model.addTimings(dailyTimeModel);
                      return Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    if (model.city != null)
                                      Text(
                                        model.city!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    Text(
                                      data[index].hijriDate,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      data[index].hijriMonth,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.start,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.namaz,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.end,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 15,
                              child: ListView(
                                padding: const EdgeInsets.all(0),
                                children: List.generate(
                                    model.clr.length,
                                    ((entry) => ConstrainedBox(
                                          constraints: const BoxConstraints(
                                              minHeight: 60),
                                          child: Card(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 18.0),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      model.startTime[entry]
                                                          .asString(),
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Text(model
                                                            .entries[entry]),
                                                        model.startTime[entry]
                                                                    .compareTo(
                                                                        TimeOfDay
                                                                            .now())
                                                                    .isNegative &&
                                                                model.endTime[
                                                                            entry]
                                                                        .compareTo(
                                                                            TimeOfDay.now()) >
                                                                    0
                                                            ? SlideCountdownSeparated(
                                                                duration: model
                                                                    .endTime[
                                                                        entry]
                                                                    .difference(
                                                                        TimeOfDay
                                                                            .now()),
                                                              )
                                                            : const SizedBox(),
                                                      ],
                                                    ),
                                                    Text(
                                                      model.endTime[entry]
                                                          .asString(),
                                                    )
                                                  ]),
                                            ),
                                          ),
                                        ))),
                              ))
                        ],
                      );
                    } else {
                      return Text(AppLocalizations.of(context)!.noCitySelected);
                    }
                  },
                  error: (e, s) => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () =>
                                    ref.invalidate(apiRepoProvider),
                                child: const Text('Retry')),
                            Text(e.toString()),
                          ],
                        ),
                      ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()))),
        ],
      ),
    );
  }
}
