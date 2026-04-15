import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';

class CustomRestDay extends StatelessWidget {
  const CustomRestDay({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('😴', style: TextStyle(fontSize: 40.sp)),
          8.verticalSpace,
          Text(
            'Rest & Recovery Day',
            style: AppTextStyles.font14Medium(context)
                .copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
