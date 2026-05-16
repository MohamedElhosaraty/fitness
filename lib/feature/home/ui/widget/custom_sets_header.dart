import 'package:fitness/core/theming/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/localization_methods.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/app_strings.dart';

class CustomSetsHeader extends StatelessWidget {
  const CustomSetsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final headers = [
      tr(context, AppStrings.set),
      tr(context, AppStrings.weight),
      tr(context, AppStrings.reps),
      tr(context, AppStrings.done),
    ];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.white4)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
          for (final header in headers)
            Text(
              header,
              style: AppTextStyles.font13Bold(context).copyWith(
                color: AppColors.blueTertiary,
                letterSpacing: 0.7,
              ),
            ),
        ]
      ),
    );
  }
}
