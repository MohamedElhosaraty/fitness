import 'package:fitness/core/helpers/extensions.dart';
import 'package:fitness/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/localization/localization_methods.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';

class CustomOnboardingBottom extends StatelessWidget {
  const CustomOnboardingBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          key: const Key('continueButton'),
          yPadding: 15,
          onPressed: () {
            context.pushReplacementNamed(Routes.mainScreen,);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tr(context, 'continue'),
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
          tr(context, "changeLater"),
          style: AppTextStyles.font10Medium(
            context,
          ).copyWith(color: AppColors.grey, letterSpacing: 0.6),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
