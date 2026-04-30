import 'package:fitness/core/localization/localization_methods.dart';
import 'package:fitness/feature/home/ui/widget/custom_active_plan_card.dart';
import 'package:fitness/feature/home/ui/widget/custom_bottom_to_finish_exercise_day.dart';
import 'package:fitness/feature/home/ui/widget/custom_home_info.dart';
import 'package:fitness/feature/home/ui/widget/custom_number_day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import 'custom_exercise_bloc_builder.dart';
import 'custom_home_top_bar.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          const CustomHomeTopBar(),
          20.verticalSpace,
          const CustomNumberDay(),
          20.verticalSpace,
          const CustomActivePlanCard(),
          12.verticalSpace,
          Text(
            tr(context, "todayExercises"),
            style: AppTextStyles.font20Bold(context).copyWith(
              color: AppColors.black,
            ),
          ),
          16.verticalSpace,
          const CustomExerciseBlocBuilder(),
          12.verticalSpace,
          const CustomHomeInfo(),
          12.verticalSpace,
          const CustomBottomToFinishExerciseDay(),
          20.verticalSpace,
        ],
      ),
    );
  }
}
