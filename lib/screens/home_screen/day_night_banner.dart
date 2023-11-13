import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jalgaon_namaz_timing/constants/constants.dart';
import 'package:jalgaon_namaz_timing/utils/app_colors.dart';

double mapRange(
  double value,
  double iMin,
  double iMax, [
  double oMin = 0,
  double oMax = 1,
]) {
  return ((value - iMin) * (oMax - oMin)) / (iMax - iMin) + oMin;
}

const SUN_MOON_WIDTH = 100.0;

class DayNightBanner extends ConsumerWidget {
  const DayNightBanner({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final displace = mapRange(AppColors.currentHour * 1.0, 0, 23);
    return AnimatedContainer(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      duration: const Duration(seconds: 2),
      height: 150,
      color: AppColors.ans,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth.round() - SUN_MOON_WIDTH;
          final top = sin(pi * displace) * 1.8;
          final left = maxWidth * displace;
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              AnimatedPositioned(
                curve: Curves.ease,
                bottom: top * 20,
                left: left,
                duration: const Duration(seconds: 2),
                child: SunMoon(
                  isSun: AppColors.isDay,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class SunMoon extends StatelessWidget {
  final bool? isSun;
  const SunMoon({
    Key? key,
    this.isSun,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SUN_MOON_WIDTH,
      child: AnimatedSwitcher(
        switchInCurve: Curves.ease,
        switchOutCurve: Curves.ease,
        duration: const Duration(seconds: 1),
        child: isSun!
            ? Container(
                key: const ValueKey(1),
                child: const Image(
                  image: AssetImage(
                    Images.sun,
                  ),
                ))
            : Container(
                key: const ValueKey(2),
                child: const Image(
                  image: AssetImage(Images.moon),
                ),
              ),
        transitionBuilder: (child, anim) {
          return ScaleTransition(
            scale: anim,
            child: FadeTransition(
              opacity: anim,
              child: SlideTransition(
                position: anim.drive(
                  Tween(
                    begin: const Offset(0, 4),
                    end: const Offset(0, 0),
                  ),
                ),
                child: child,
              ),
            ),
          );
        },
      ),
    );
  }
}
