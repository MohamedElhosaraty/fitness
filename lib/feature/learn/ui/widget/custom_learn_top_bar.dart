import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/localization/localization_methods.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../generated/app_strings.dart';


class CustomLearnTopBar extends StatelessWidget {
  const CustomLearnTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr(context, AppStrings.expertKnowledge),
                style: AppTextStyles.font12Medium(context).copyWith(
                  color: AppColors.greySecondary,
                  letterSpacing: 1.2,
                ),
              ),
              4.verticalSpace,
              Text(
                tr(context, AppStrings.tipsAndEssentials),
                style: AppTextStyles.font20Bold(context).copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              4.verticalSpace,
              Text(
                tr(context, AppStrings.tipsAndEssentialsSubtitle),
                style: AppTextStyles.font12Medium(context).copyWith(
                  color: AppColors.greySecondary,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 38.w,
          height: 38.w,
          decoration: BoxDecoration(
            color: AppColors.white2,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(
            Icons.search_rounded,
            size: 20.sp,
            color: AppColors.greySecondary,
          ),
        ),
      ],
    );
  }
}