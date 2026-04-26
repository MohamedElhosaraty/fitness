import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';

class CustomOnboardingTopBar extends StatelessWidget {
  const CustomOnboardingTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isAr = context.locale.languageCode == 'ar';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'fitFlow'.tr(),
          style: AppTextStyles.font19Bold(context).copyWith(
            color: AppColors.primaryColor,
          ),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                context.setLocale(
                  isAr ? const Locale('en') : const Locale('ar'),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.white2,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border),
                ),
                child: Text(
                  isAr ? 'EN' : 'ع',
                  style: AppTextStyles.font13Bold(context).copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
            10.horizontalSpace,
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: AppColors.border, width: 1.5),
              ),
              child: const Icon(
                  Icons.help_outline, size: 20, color: AppColors.moreGrey),
            ),
          ],
        ),
      ],
    );
  }
}
