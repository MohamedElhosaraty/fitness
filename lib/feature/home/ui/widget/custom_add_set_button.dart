import 'package:fitness/core/localization/localization_methods.dart';
import 'package:fitness/core/theming/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../generated/app_strings.dart';

class CustomAddSetButton extends StatelessWidget {
  const CustomAddSetButton({super.key, required void Function() addSet}) : _addSet = addSet;

  final void Function() _addSet;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _addSet,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.white4)),
        ),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, size: 16, color: AppColors.primaryColor),
            4.horizontalSpace,
            Text(
              tr(context, AppStrings.addSet),
              style: AppTextStyles.font14Medium(context)
            ),
          ],
        ),
      ),
    );
  }
}
