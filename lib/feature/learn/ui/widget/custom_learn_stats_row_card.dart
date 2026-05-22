import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';

class CustomLearnStatsRowCard extends StatelessWidget {

  final String value;
  final String label;

  const CustomLearnStatsRowCard({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: AppColors.white2,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: AppTextStyles.font16Bold(
                context,
              ).copyWith(color: AppColors.primaryColor),
            ),
            4.verticalSpace,
            Text(
              label,
              style: AppTextStyles.font10Medium(
                context,
              ).copyWith(color: AppColors.greySecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
