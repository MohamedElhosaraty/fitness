import 'package:fitness/feature/profile/ui/widget/custom_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/localization/localization_methods.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../generated/app_strings.dart';

class CustomProfileTopBar extends StatelessWidget {
  const CustomProfileTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CustomProfileAvatar(
          size: 40,
          borderWidth: 1,
        ),
        12.horizontalSpace,
        Text(
          tr(context, AppStrings.healthProfile),
          style: AppTextStyles.font16Bold(context).copyWith(
            color: AppColors.black,
          ),
        ),
        Spacer(),
        Container(
          width: 42.w,
          height: 42.h,
          decoration: BoxDecoration(
            color: AppColors.white2,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.settings_outlined,
            color: AppColors.primaryColor,
            size: 22,
          ),
        ),
      ],
    );
  }
}

