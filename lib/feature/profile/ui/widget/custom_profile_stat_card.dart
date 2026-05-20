import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';

class CustomProfileStatCard extends StatelessWidget {
  const CustomProfileStatCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.white4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: AppColors.primaryColor, size: 20),
              ),
              4.horizontalSpace,
              Text(
                label,
                style: AppTextStyles.font10Bold(context).copyWith(
                  color: AppColors.grey,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
          6.verticalSpace,
          Text(
            value,
            style: AppTextStyles.font16Bold(context).copyWith(
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
