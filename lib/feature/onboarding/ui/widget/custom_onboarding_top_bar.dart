import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/extensions.dart';
import '../../../../core/localization/localization_methods.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../core/localization/cubit/localization_cubit.dart';

class CustomOnboardingTopBar extends StatelessWidget {
  const CustomOnboardingTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<LocalizationCubit>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          tr(context, "fitFlow"),
          style: AppTextStyles.font19Bold(context).copyWith(
            color: AppColors.primaryColor,
          ),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                final isAr = cubit.currentLocale.languageCode == 'ar';
                cubit.changeLanguage(isAr);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.white2,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border),
                ),
                child: Text(
                  context.currentLang == 'en' ? 'EN' : 'ع',
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
                border: Border.all(color: AppColors.border, width: 1.5),
              ),
              child: const Icon(
                Icons.help_outline,
                size: 20,
                color: AppColors.moreGrey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}