import 'package:fitness/core/theming/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';

class CustomChooseTrainingCard extends StatelessWidget {
  const CustomChooseTrainingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: AppColors.primaryColor.withValues(alpha: 0.5),),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Step 1: Select Your Split",
            style: AppTextStyles.font19Bold(context)
                .copyWith(color: AppColors.darkBlue),
          ),
          10.verticalSpace,
          Text(
            "Choose how you want to organize your weekly training",
            style: AppTextStyles.font14Regular(context)
                .copyWith(color: AppColors.moreGrey),
          ),
        ],
      ),
    );
  }
}
