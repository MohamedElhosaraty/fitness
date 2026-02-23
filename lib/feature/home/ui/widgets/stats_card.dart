import 'package:fitness/core/theming/app_colors.dart';
import 'package:fitness/core/theming/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final bool isDay;

  const StatsCard({
    super.key,
    required this.title,
    required this.value,
    this.isDay = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              title,
              style: AppTextStyles.font12Medium(context).copyWith(
                color: AppColors.moreGrey,
              )
          ),
          6.verticalSpace,
          Text(
            value,
            style:AppTextStyles.font16Bold(context).copyWith(
              color: isDay ? AppColors.orange : AppColors.primaryColor,
            )
          ),
        ],
      ),
    );
  }
}
