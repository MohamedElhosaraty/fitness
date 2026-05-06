import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/localization/localization_methods.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../generated/app_strings.dart';

class CustomOnboardingHeader extends StatelessWidget {
  const CustomOnboardingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr(context, AppStrings.selectGoal),
          style: AppTextStyles.font34Bold(context).copyWith(
            color: AppColors.black,
          ),
        ),
        6.verticalSpace,
        Text(
          tr(context, AppStrings.customizeJourney),
          style: AppTextStyles.font14Regular(context).copyWith(
            color: AppColors.moreGrey,
          ),
        ),
        ],
    );
  }
}
