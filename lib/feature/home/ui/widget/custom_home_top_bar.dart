import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/localization/localization_methods.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../generated/app_strings.dart';

class CustomHomeTopBar extends StatelessWidget {
  const CustomHomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr(context, AppStrings.goodMorning),
              style: AppTextStyles.font20Bold(context).copyWith(
              ),
            ),
            2.verticalSpace,
            Text(
              tr(context, AppStrings.letGetToWork),
              style: AppTextStyles.font14Regular(context).copyWith(
                color: AppColors.grey,
              ),
            ),
          ],
        ),
        Container(
          width: 42.w,
          height: 42.h,
          decoration: BoxDecoration(
            color: AppColors.white2,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.settings_outlined,
            color: AppColors.black,
            size: 22,
          ),
        ),
      ],
    );
  }
}
