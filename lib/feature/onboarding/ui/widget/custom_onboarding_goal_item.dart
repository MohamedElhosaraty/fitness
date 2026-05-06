import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../data/model/onboarding_goal_model.dart';

class CustomOnboardingGoalItem extends StatelessWidget {
  final OnboardingGoalModel goal;
  final bool isSelected;
  final VoidCallback onTap;
  final String locale;
  final int index;

  const CustomOnboardingGoalItem({
    super.key,
    required this.goal,
    required this.isSelected,
    required this.onTap,
    required this.locale,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        key: isSelected ? Key('goalItemSelected_$index') : null,
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : AppColors.border,
            width: isSelected ? 2 : 1.5,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: AppColors.primaryColor.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ] : [],
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryColor.withValues(alpha: 0.1)
                    : AppColors.white2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                goal.iconData,
                color: isSelected ? AppColors.primaryColor : AppColors.moreGrey,
                size: 22,
              ),
            ),
            14.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    goal.getTitle(locale),
                    style: AppTextStyles.font16Bold(context)
                        .copyWith(color: AppColors.black),
                  ),
                  3.verticalSpace,
                  Text(
                    goal.getSubtitle(locale),
                    style: AppTextStyles.font12Medium(context).copyWith(
                      color: AppColors.moreGrey,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22.w,
              height: 22.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryColor
                      : AppColors.lightGrey,
                  width: 2,
                ),
                color: isSelected ? AppColors.primaryColor : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.circle, color: AppColors.background, size: 10)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}