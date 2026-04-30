import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';

class CustomHomeInfoCard extends StatelessWidget {
  const CustomHomeInfoCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.label,
    required this.value,
    required this.valueColor,
    required this.subtitle,
    required this.cardColor,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String label;
  final String value;
  final Color valueColor;
  final String subtitle;
  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: iconColor.withValues(alpha: 0.15), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          10.verticalSpace,
          Text(
            label,
            style: AppTextStyles.font10Bold(
              context,
            ).copyWith(color: iconColor, letterSpacing: 0.8),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTextStyles.font20Bold(
              context,
            ).copyWith(color: valueColor),
          ),
          4.verticalSpace,
          Text(
            subtitle,
            style: AppTextStyles.font12Medium(
              context,
            ).copyWith(color: AppColors.grey, height: 1.3),
          ),
        ],
      ),
    );
  }
}
