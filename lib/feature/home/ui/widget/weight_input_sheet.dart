import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/localization/localization_methods.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../generated/app_strings.dart';

class WeightInputDialog extends StatefulWidget {
  const WeightInputDialog({super.key, required this.initialWeight });

  final double initialWeight;

  @override
  State<WeightInputDialog> createState() => _WeightInputDialogState();
}

class _WeightInputDialogState extends State<WeightInputDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.initialWeight % 1 == 0
          ? widget.initialWeight.toInt().toString()
          : widget.initialWeight.toString(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final parsed = double.tryParse(_controller.text) ?? 0;
    final weight = parsed > 0 ? parsed : widget.initialWeight;
    Navigator.pop(context, weight);
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
              textAlign: TextAlign.center,
              style: AppTextStyles.font20Bold(context),
            ),
            8.verticalSpace,
            Text(
              tr(context, AppStrings.dontWorry),
              textAlign: TextAlign.center,
              style: AppTextStyles.font14Regular(context)
                  .copyWith(color: AppColors.greySecondary),
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
                    style: AppTextStyles.font17Medium(context)
                        .copyWith(color: AppColors.greySecondary),
                  ),
                ],
              ),
            ),
            24.verticalSpace,
            CustomButton(
              onPressed: _submit,
              child: Text(
                tr(context, AppStrings.saveAndStart),
                style: AppTextStyles.font17Medium(context)
                    .copyWith(color: AppColors.background),
              ),
            ),
            4.verticalSpace,
            TextButton(
              onPressed: () => Navigator.pop(context, widget.initialWeight),
              child: Text(
                tr(context, AppStrings.useDefault),
                style: AppTextStyles.font17Medium(context)
                    .copyWith(color: AppColors.greySecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}