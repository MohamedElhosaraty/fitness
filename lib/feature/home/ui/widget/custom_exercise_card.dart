import 'package:fitness/core/localization/localization_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';

class CustomExerciseCard extends StatelessWidget {
  final String name;
  final String muscle;
  final String repsDisplay;
  final IconData icon;

  const CustomExerciseCard({
    super.key,
    required this.name,
    required this.muscle,
    required this.repsDisplay,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.h,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primaryColor, size: 22),
          ),
          14.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyles.font14Medium(
                    context,
                  ).copyWith(color: AppColors.black),
                ),
                3.verticalSpace,
                Text(
                  muscle,
                  style: AppTextStyles.font12Medium(
                    context,
                  ).copyWith(color: AppColors.grey),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                repsDisplay,
                textDirection: TextDirection.ltr,
                style: AppTextStyles.font13Bold(
                  context,
                ).copyWith(color: AppColors.primaryColor),
              ),
              3.verticalSpace,
              Text(
                tr(context, "REPS"),
                style: AppTextStyles.font10Bold(
                  context,
                ).copyWith(color: AppColors.grey, letterSpacing: 0.8),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
