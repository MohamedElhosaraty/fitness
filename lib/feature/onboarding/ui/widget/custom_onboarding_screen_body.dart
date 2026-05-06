import 'package:fitness/feature/onboarding/ui/widget/custom_onboarding_bottom.dart';
import 'package:fitness/feature/onboarding/ui/widget/custom_onboarding_goal_bloc_builder.dart';
import 'package:fitness/feature/onboarding/ui/widget/custom_select_day.dart';
import 'package:flutter/material.dart';

import 'package:fitness/core/theming/app_colors.dart';
import 'package:fitness/core/theming/app_text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/user_preferences.dart';
import '../../../../core/localization/localization_methods.dart';
import '../../../../generated/app_strings.dart';
import '../widget/custom_onboarding_header.dart';
import '../widget/custom_onboarding_top_bar.dart';
import '../widget/custom_recommended_card.dart';

class OnboardingScreenBody extends StatelessWidget {
  const OnboardingScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          children: [
            const CustomOnboardingTopBar(),
            40.verticalSpace,
            const CustomOnboardingHeader(),
            28.verticalSpace,
            const CustomOnboardingGoalBlocBuilder(),
            28.verticalSpace,
            Text(
              tr(context, AppStrings.weeklyAvailability),
              style: AppTextStyles.font20Bold(context).copyWith(
                color: AppColors.black,
              ),
            ),
            14.verticalSpace,
            const CustomSelectDay(),
            20.verticalSpace,
            ListenableBuilder(
              listenable: Listenable.merge([
                UserPreferences.selectedGoalNotifier,
                UserPreferences.numberDaysNotifier,
              ]),
              builder: (context, _) {
                final isGetStrong = UserPreferences.selectedGoalNotifier.value == "getStrong";
                final isThreeDays = UserPreferences.numberDaysNotifier.value == 3;

                if (isGetStrong && isThreeDays) {
                  return const CustomRecommendedCard();
                }
                return const SizedBox.shrink();
              },
            ),
            28.verticalSpace,
            const CustomOnboardingBottom(),
          ],
        ),
      );

  }

}

