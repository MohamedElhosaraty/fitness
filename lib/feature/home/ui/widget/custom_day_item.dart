import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../core/utils/home_day_utils.dart';

class CustomDayItem extends StatelessWidget {
  const CustomDayItem({
    super.key,
    required this.label,
    required this.number,
    required this.status,
  });

  final String label;
  final int number;
  final HomeDayStatus status;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;

    switch (status) {
      case HomeDayStatus.active:
        backgroundColor = AppColors.primaryColor;
        textColor = AppColors.background;
        break;

      case HomeDayStatus.finished:
        backgroundColor = AppColors.primaryColor;
        textColor = AppColors.background;
        break;

      case HomeDayStatus.reset:
        backgroundColor = AppColors.primaryColor.withValues(alpha: 0.30);
        textColor = AppColors.background;
        break;
    }

    return Column(
      children: [
        Text(
          label,
          style: AppTextStyles.font12Medium(
            context,
          ).copyWith(color: AppColors.grey),
        ),
        6.verticalSpace,
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 38.w,
          height: 38.h,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child:
                status == HomeDayStatus.finished
                    ? Icon(Icons.check, color: textColor, size: 20.sp)
                    : Text(
                      '$number',
                      style: AppTextStyles.font14Medium(
                        context,
                      ).copyWith(color: textColor),
                    ),
          ),
        ),
      ],
    );
  }
}
