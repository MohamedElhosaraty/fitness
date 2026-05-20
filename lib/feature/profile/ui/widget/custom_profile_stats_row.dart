import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/user_preferences.dart';
import '../../../../core/localization/localization_methods.dart';
import '../../../../generated/app_strings.dart';
import '../../../../core/helpers/profile_helpers.dart';
import 'custom_profile_stat_card.dart';

class CustomProfileStatsRow extends StatelessWidget {
  const CustomProfileStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final goalId = UserPreferences.selectedGoal;
    final goalTitle = profileGoalTitle(context, goalId);
    final frequency = profileFrequencyLabel(context);

    return Row(
      children: [
        Expanded(
          child: CustomProfileStatCard(
            icon: Icons.fitness_center_rounded,
            label: tr(context, AppStrings.activeGoal),
            value: goalTitle,
          ),
        ),
        12.horizontalSpace,
        Expanded(
          child: CustomProfileStatCard(
            icon: Icons.calendar_today_rounded,
            label: tr(context, AppStrings.frequency),
            value: frequency,
          ),
        ),
      ],
    );
  }
}
