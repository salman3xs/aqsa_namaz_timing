import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jalgaon_namaz_timing/screens/home_screen/providers/home_provider.dart';
import 'package:slide_countdown/slide_countdown.dart';
import '../../repository/api/api_repo.dart';
import 'day_night_banner.dart';
import 'package:jalgaon_namaz_timing/extension/time_of_day_extensions.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final api = ref.watch(apiRepoProvider);
    final model = ref.watch(homeNotifier);
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: DayNightBanner(),
        ),
        Container(
          height: size.height - 250,
          child: api.when(
              data: (data) {
                if (data != null) {
                  final controller =
                      useTabController(initialLength: data.length);
                  controller.index = DateTime.now().day;
                  return Column(
                    children: [
                      TabBar(
                          isScrollable: true,
                          labelColor: Colors.white,
                          controller: controller,
                          tabs: data
                              .map((e) => Tab(
                                    text: e.day.toString(),
                                  ))
                              .toList()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Start',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Namaz',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'End',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: controller,
                          children: data.map((dailyTimeModel) {
                            model.addTimings(dailyTimeModel);
                            return ListWheelScrollView(
                              diameterRatio: 4,
                              itemExtent: 75,
                              children: [
                                ...List.generate(
                                    model.clr.length,
                                    ((entry) => Card(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
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
                                                      Text(
                                                          model.entries[entry]),
                                                      model.startTime[entry]
                                                                  .compareTo(
                                                                      TimeOfDay
                                                                          .now())
                                                                  .isNegative &&
                                                              model.endTime[
                                                                          entry]
                                                                      .compareTo(
                                                                          TimeOfDay
                                                                              .now()) >
                                                                  0
                                                          ? SlideCountdownSeparated(
                                                              duration: model
                                                                  .endTime[
                                                                      entry]
                                                                  .difference(
                                                                      TimeOfDay
                                                                          .now()),
                                                            )
                                                          : SizedBox(),
                                                    ],
                                                  ),
                                                  Text(
                                                    model.endTime[entry]
                                                        .asString(),
                                                  )
                                                ]),
                                          ),
                                        )))
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Text('No City Selected');
                }
              },
              error: (e, s) {
                print('apiRepo' + e.toString());
                return Center(
                  child: Text(e.toString()),
                );
              },
              loading: () => Center(child: CircularProgressIndicator())),
        ),
      ],
    );
  }
}
