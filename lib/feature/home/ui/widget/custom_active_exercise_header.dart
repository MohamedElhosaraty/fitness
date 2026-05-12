import 'package:fitness/core/localization/localization_methods.dart';
import 'package:fitness/core/theming/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../generated/app_strings.dart';

class CustomActiveExerciseHeader extends StatelessWidget {
  const CustomActiveExerciseHeader({super.key, required this.onNext, required this.isLast});

  final VoidCallback onNext;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        left: 16,
        right: 16,
        bottom: 12,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, size: 22),
            color: AppColors.moreGrey,
          ),
          8.horizontalSpace,
          Text(
            tr(context, AppStrings.workoutSession),
            style: AppTextStyles.font16Bold(context).copyWith(
              color: AppColors.black,
            ),
          ),
          Spacer(),
          TextButton(
            onPressed: onNext,
            child: Text(
              isLast ? tr(context, AppStrings.finish) : tr(context, AppStrings.nextExercise),
              style: AppTextStyles.font16Bold(context),
            ),
          ),
        ],
      ),
    );
  }
}
