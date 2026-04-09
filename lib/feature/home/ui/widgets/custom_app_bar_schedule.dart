import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';

class CustomAppBarSchedule extends StatelessWidget {
  const CustomAppBarSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        25.horizontalSpace,
        Text(
          'Weekly Schedule',
          textAlign: TextAlign.center,
          style: AppTextStyles.font20Bold(context).copyWith(
            color: AppColors.black,
          ),
        ),
      ],
    );
  }
}
