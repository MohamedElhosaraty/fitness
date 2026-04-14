import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../data/model/day_schedule_model.dart';

class CustomFocusCard extends StatelessWidget {
  const CustomFocusCard({super.key, required this.day});

  final DayScheduleModel day ;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.calendar_today,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
              12.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${day.category?.name ?? ''} Day',
                    style: AppTextStyles.font16Bold(context)
                        .copyWith(color: AppColors.black),
                  ),
                  4.verticalSpace,
                  Text(
                    '${day.exercises.length} exercises',
                    style: AppTextStyles.font14Regular(context)
                        .copyWith(color: AppColors.moreGrey),
                  ),
                ],
              ),
            ],
          ),
        ),
        24.verticalSpace,
        CustomButton(
          text: "▶  Start Today's Workout",
          onPressed: () {},
        ),
      ],
    );
  }
}
