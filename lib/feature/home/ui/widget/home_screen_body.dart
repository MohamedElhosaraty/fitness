import 'package:fitness/core/localization/localization_methods.dart';
import 'package:fitness/feature/home/ui/widget/custom_active_plan_card.dart';
import 'package:fitness/feature/home/ui/widget/custom_exercise_list_section_bloc_builder.dart';
import 'package:fitness/feature/home/ui/widget/custom_number_day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../core/utils/home_day_utils.dart';
import '../../../../generated/app_strings.dart';
import 'custom_home_info.dart';
import 'custom_home_top_bar.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  HomeDaySlotUtility? _homeDaySlot;

  @override
  void initState() {
    super.initState();
    _loadSlot();
  }

  Future<void> _loadSlot() async {
    final slot = await HomeDaySlotUtility.get();
    if (!mounted) return;
    setState(() => _homeDaySlot = slot);
  }

  @override
  Widget build(BuildContext context) {

    if (_homeDaySlot == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final homeDaySlot = _homeDaySlot!;
    return SafeArea(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          const CustomHomeTopBar(),
          20.verticalSpace,
          CustomNumberDay(
            activeSlots: homeDaySlot.activeSlots,
            currentSlot: homeDaySlot.currentSlot,
            finishedSlots: homeDaySlot.finishedSlots,
          ),
          20.verticalSpace,
          CustomActivePlanCard(
            dayExerciseModel: homeDaySlot.currentWorkoutDay,
            currentSlot: homeDaySlot.currentSlot,
            onWorkoutFinished: _loadSlot,
          ),
          12.verticalSpace,
          Text(
            tr(context, AppStrings.todayExercises),
            style: AppTextStyles.font20Bold(context).copyWith(
              color: AppColors.black,
            ),
          ),
          16.verticalSpace,
          const CustomExerciseListSectionBlocBuilder(),
          12.verticalSpace,
          const CustomHomeInfo(),
          20.verticalSpace,
        ],
      ),
    );
  }
}