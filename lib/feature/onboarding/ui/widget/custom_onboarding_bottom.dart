import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';

class CustomOnboardingBottom extends StatelessWidget {
  const CustomOnboardingBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          yPadding: 15,
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'continue'.tr(),
                style: AppTextStyles.font16Bold(
                  context,
                ).copyWith(color: AppColors.background),
              ),
              8.horizontalSpace,
              Icon(
                 Icons.arrow_forward,
                size: 20,
                color: AppColors.background,
              ),
            ],
          ),
        ),
        10.verticalSpace,
        Text(
          'changeLater'.tr(),
          style: AppTextStyles.font10Medium(
            context,
          ).copyWith(color: AppColors.grey, letterSpacing: 0.6),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
