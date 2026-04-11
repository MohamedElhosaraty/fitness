import 'package:fitness/core/theming/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';
import '../../data/model/exercise_model.dart';

class CustomExercisesCard extends StatelessWidget {

  final VoidCallback onTap;
  final ExerciseModel exercise;

  const CustomExercisesCard({
    super.key,
    required this.onTap, required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: exercise.isSelected ? AppColors.primaryColor.withValues(alpha: .05)
            : AppColors.background,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 2,
            color: exercise.isSelected
                ? AppColors.primaryColor
                : AppColors.grey.withValues(alpha: .4),
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.name,
                  style: AppTextStyles.font20Bold(context).copyWith(
                    color: AppColors.darkBlue,
                  )
                ),
                6.verticalSpace,
                Text(
                  exercise.muscle,
                  style: AppTextStyles.font14Medium(context).copyWith(
                      color: AppColors.moreGrey),
                ),
              ],
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: exercise.isSelected
                  ? const Icon(
                Icons.check_circle,
                key: ValueKey(true),
                color: Color(0xFF3B82F6),
              )
                  : const SizedBox(
                key: ValueKey(false),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
