import 'package:fitness/feature/home/ui/widgets/last_workout_card.dart';
import 'package:fitness/feature/home/ui/widgets/quick_actions.dart';
import 'package:fitness/feature/home/ui/widgets/stats_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/focus_card.dart';
import '../widgets/home_header.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          10.verticalSpace,
          //const HomeHeader(),
          16.verticalSpace,
          const StatsSection(),
          30.verticalSpace,
          const FocusCard(),
          32.verticalSpace,
          const QuickActions(),
          32.verticalSpace,
          const LastWorkoutCard(),
        ],
      ),
    );
  }
}
