import 'package:fitness/core/theming/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';

class CustomSelectExercisesHeader extends StatelessWidget {
  const CustomSelectExercisesHeader({super.key, required this.selectedCount});

  final int selectedCount ;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primaryColor.withValues(alpha: 0.5),),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                  Icons.fitness_center,
                  color: AppColors.orange,),
              12.horizontalSpace,
              Text(
                "Tuesday - Lower",
                style: AppTextStyles.font20Bold(context).copyWith(
                  color: AppColors.darkBlue,
                )
              ),
            ],
          ),
          5.verticalSpace,
          Text(
            "Select exercises for this workout ($selectedCount selected)",
              style: AppTextStyles.font14Medium(context).copyWith(
                color: AppColors.textSecondary,
              )
          ),
        ],
      ),
    );
  }
}
