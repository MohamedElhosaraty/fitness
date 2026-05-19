import 'package:fitness/core/theming/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/localization/localization_methods.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/app_strings.dart';

class CustomSetsHeader extends StatelessWidget {
  const CustomSetsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: const BoxDecoration(
        color: AppColors.white4,
        borderRadius:  BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ),
        border: Border(bottom: BorderSide(color: AppColors.white4)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              tr(context, AppStrings.set),
              textAlign: TextAlign.start,
              style: AppTextStyles.font13Bold(context).copyWith(
                color: AppColors.blueTertiary,
                letterSpacing: 0.7,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              tr(context, AppStrings.weight),
              textAlign: TextAlign.center,
              style: AppTextStyles.font13Bold(context).copyWith(
                color: AppColors.blueTertiary,
                letterSpacing: 0.7,
              ),
            ),
          ),
          12.horizontalSpace,
          Expanded(
            flex: 3,
            child: Text(
              tr(context, AppStrings.reps),
              textAlign: TextAlign.center,
              style: AppTextStyles.font13Bold(context).copyWith(
                color: AppColors.blueTertiary,
                letterSpacing: 0.7,
              ),
            ),
          ),
          12.horizontalSpace,
          SizedBox(
            width: 50.w,
            child: Text(
              tr(context, AppStrings.done),
              textAlign: TextAlign.center,
              style: AppTextStyles.font13Bold(context).copyWith(
                color: AppColors.blueTertiary,
                letterSpacing: 0.7,
              ),
            ),
          ),
        ],
      ),
    );
  }
}