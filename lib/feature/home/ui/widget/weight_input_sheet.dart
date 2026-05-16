import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/localization/localization_methods.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../generated/app_strings.dart';


class WeightInputDialog extends StatefulWidget {
  const WeightInputDialog({super.key});

  @override
  State<WeightInputDialog> createState() => _WeightInputDialogState();
}

class _WeightInputDialogState extends State<WeightInputDialog> {
  final TextEditingController _controller = TextEditingController(text: '25');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              tr(context, AppStrings.enterStartingWeight),
              style: AppTextStyles.font20Bold(context)
            ),
            8.verticalSpace,
            Text(
              tr(context, AppStrings.dontWorry),
              textAlign: TextAlign.center,
              style: AppTextStyles.font14Regular(context).copyWith(color: AppColors.greySecondary),
            ),
            24.verticalSpace,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: AppColors.white2,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 80.w,
                    child: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                  Text(
                    'kg',
                    style: AppTextStyles.font17Medium(context).copyWith(color: AppColors.greySecondary),
                  ),
                ],
              ),
            ),
            24.verticalSpace,
            CustomButton(
              onPressed: () {
                final weight = double.tryParse(_controller.text) ?? 25.0;
                Navigator.pop(context, weight);
              },
              child: Text(
                tr(context, AppStrings.saveAndStart),
                style: AppTextStyles.font17Medium(context).copyWith(color: AppColors.background),
              ),
            ),
            4.verticalSpace,
            TextButton(
              onPressed: () => Navigator.pop(context, 25.0),
              child: Text(
                tr(context, AppStrings.useDefault),
                style: AppTextStyles.font17Medium(context).copyWith(color: AppColors.greySecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}