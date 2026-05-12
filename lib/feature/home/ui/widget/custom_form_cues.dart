import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/localization/localization_methods.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../generated/app_strings.dart';

class CustomFormCues extends StatelessWidget {
  const CustomFormCues({super.key});


  @override
  Widget build(BuildContext context) {
     List<String> cues = [
      tr(context, AppStrings.keepShouldersBackThroughoutMovement),
      tr(context, AppStrings.driveThroughHeels),
      tr(context, AppStrings.elbowsShouldTrackInsideYourKnees),
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white2,
        border: Border.all(color: AppColors.blueSecondary),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 18.w,
                height: 18.h,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
                child:  Center(
                  child: Text(
                    'i',
                    style: AppTextStyles.font10Bold(context).copyWith(
                      color: AppColors.background,
                    ),
                  ),
                ),
              ),
              6.horizontalSpace,
              Text(
                tr(context, AppStrings.formCues),
                style: AppTextStyles.font16Bold(context).copyWith(
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
          10.verticalSpace,
          ...cues.map((cue) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 5.w,
                  height: 5.h,
                  margin: const EdgeInsets.only(top: 6, right: 8),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(
                    cue,
                    style: AppTextStyles.font14Medium(context).copyWith(
                      height: 1.45,
                      color: AppColors.blueTertiary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ),
        ],
      ),
    );
  }
}