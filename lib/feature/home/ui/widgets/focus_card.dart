import 'package:fitness/core/helpers/extensions.dart';
import 'package:fitness/core/theming/app_colors.dart';
import 'package:fitness/core/theming/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_button.dart';

class FocusCard extends StatelessWidget {
  const FocusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
            spreadRadius: 2,
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  "TODAY’S FOCUS",
                  style: AppTextStyles.font10Bold(context),
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  context.pushNamed(Routes.chooseTrainingSplitView);
                },
                child: Row(
                  children: [
                    Text(
                      "Schedule",
                      style: AppTextStyles.font16Bold(
                        context,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: AppColors.primaryColor,
                      size: 24.sp,
                    ),
                  ],
                ),
              )
            ],
          ),
          3.verticalSpace,
          Text(
            "Leg Day (Push)",
            style: AppTextStyles.font20Bold(
              context,
            ).copyWith(color: AppColors.black),
          ),
          6.verticalSpace,
          Text(
            "6 Exercises • 45 mins",
            style: AppTextStyles.font14Regular(
              context,
            ).copyWith(color: AppColors.moreGrey),
          ),
          24.verticalSpace,
          CustomButton(
            borderRadius: 10,
              text: "Start Workout", onPressed: () {}),
        ],
      ),
    );
  }
}
