import 'package:fitness/feature/home/ui/widget/custom_day_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/localization/localization_methods.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../core/utils/home_day_utils.dart';
import '../../../../generated/app_strings.dart';

class CustomNumberDay extends StatelessWidget {
  const CustomNumberDay({
    super.key,
    required this.activeSlots,
    required this.currentSlot,
    required this.finishedSlots,
  });

  final List<int?> activeSlots;
  final int? currentSlot;
  final List<int> finishedSlots;

  List<String> _dayLabels (BuildContext context) => [
    tr(context, AppStrings.daySaturday),
    tr(context, AppStrings.daySunday),
    tr(context, AppStrings.dayMonday),
    tr(context, AppStrings.dayTuesday),
    tr(context, AppStrings.dayWednesday),
    tr(context, AppStrings.dayThursday),
    tr(context, AppStrings.dayFriday),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tr(context, AppStrings.weeklyBlueprint),
              style: AppTextStyles.font16Bold(context).copyWith(
                color: AppColors.black,
              ),
            ),
            Text(
              tr(context, AppStrings.week1),
              style: AppTextStyles.font14Medium(context),
            ),
          ],
        ),
        14.verticalSpace,
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white3,
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(7, (index) {
              final status = finishedSlots.contains(index)
                  ? HomeDayStatus.finished
                  : activeSlots.contains(index) || index == currentSlot
                  ? HomeDayStatus.active
                  : HomeDayStatus.reset;

              return CustomDayItem(
                label: _dayLabels(context)[index],
                number: index + 1,
                status: status,
              );
            }),
          ),
        ),
      ],
    );
  }
}