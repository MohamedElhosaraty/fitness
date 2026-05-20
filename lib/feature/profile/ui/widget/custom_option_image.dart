import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';

class CustomOptionImage extends StatelessWidget {
  const CustomOptionImage({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.white2,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.white4),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primaryColor, size: 22),
            14.horizontalSpace,
            Text(
              label,
              style: AppTextStyles.font14SemiBold(context).copyWith(
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
  }

