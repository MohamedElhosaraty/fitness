import 'package:fitness/feature/profile/ui/widget/custom_option_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/localization/cubit/localization_cubit.dart';
import '../../../../core/localization/localization_methods.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../generated/app_strings.dart';

class CustomProfileLanguageSheet extends StatelessWidget {
  const CustomProfileLanguageSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const CustomProfileLanguageSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEnglish =
        context.read<LocalizationCubit>().currentLocale.languageCode == 'en';

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr(context, AppStrings.selectLanguage),
            style: AppTextStyles.font19Bold(context).copyWith(
              color: AppColors.black,
            ),
          ),
          16.verticalSpace,
          CustomOptionLanguage(
            label: tr(context, AppStrings.englishUS),
            isSelected: isEnglish,
            onTap: () {
              context.read<LocalizationCubit>().changeLanguage(true);
              Navigator.pop(context);
            },
          ),
          8.verticalSpace,
          CustomOptionLanguage(
            label: tr(context, AppStrings.arabicEG),
            isSelected: !isEnglish,
            onTap: () {
              context.read<LocalizationCubit>().changeLanguage(false);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

