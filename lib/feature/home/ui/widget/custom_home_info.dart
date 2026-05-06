import 'package:fitness/core/localization/localization_methods.dart';
import 'package:fitness/feature/home/ui/widget/custom_home_info_card.dart';
import 'package:fitness/generated/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';

class CustomHomeInfo extends StatelessWidget {
  const CustomHomeInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomHomeInfoCard(
            icon: Icons.battery_charging_full_rounded,
            iconColor: AppColors.green,
            iconBgColor: AppColors.green.withValues(alpha: 0.12),
            label: tr(context, AppStrings.recovery),
            value: '94%',
            valueColor: AppColors.black,
            subtitle: tr(context, AppStrings.optimalStatusForTrainingToday),
            cardColor: AppColors.green.withValues(alpha:.06),
          ),
        ),
        12.horizontalSpace,
        Expanded(
          child: CustomHomeInfoCard(
            icon: Icons.local_fire_department_rounded,
            iconColor: AppColors.orange,
            iconBgColor: AppColors.orange.withValues(alpha:.12),
            label: tr(context, AppStrings.weeklyBurn),
            value: '2,450',
            valueColor: AppColors.black,
            subtitle: tr(context, AppStrings.activeKcalBurnedThisWeek),
            cardColor: AppColors.orange.withValues(alpha:.10),
          ),
        ),
      ],
    );
  }
}
