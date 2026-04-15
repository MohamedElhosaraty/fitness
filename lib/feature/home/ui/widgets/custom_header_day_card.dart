import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../data/model/day_schedule_model.dart';

class CustomHeaderDayCard extends StatelessWidget {
  const CustomHeaderDayCard({super.key, required this.day});

  final DayScheduleModel day ;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          day.dayName,
          style: AppTextStyles.font20Bold(context)
              .copyWith(color: AppColors.black),
        ),
        if (day.isToday) ...[
          10.horizontalSpace,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.1), // const Color(0xFFE3F0FC),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Today',
              style: AppTextStyles.font14Regular(context)
                  .copyWith(color: AppColors.primaryColor),
            ),
          ),
        ],
      ],
    );
  }
}

