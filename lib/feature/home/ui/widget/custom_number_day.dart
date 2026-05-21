import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../core/localization/localization_methods.dart';
import '../../../../core/utils/home_day_utils.dart';
import '../../../../generated/app_strings.dart';


class CustomNumberDay extends StatefulWidget {
  const CustomNumberDay({super.key});

  @override
  State<CustomNumberDay> createState() => CustomNumberDayState();
}

class CustomNumberDayState extends State<CustomNumberDay> {
  static const List<String> _dayLabels = ['S', 'S', 'M', 'T', 'W', 'T', 'F'];

  HomeDayUtils? _homeDayUtils;

  @override
  void initState() {
    super.initState();
    loadHomeDayUtils();
  }

  Future<void> loadHomeDayUtils() async {
    final result = await HomeDayUtils.get();
    if (mounted) {
      setState(() {
        _homeDayUtils = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeSlots = _homeDayUtils?.activeSlots ?? [];

    return _homeDayUtils == null
        ? const SizedBox()
        : Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tr(context, AppStrings.weeklyBlueprint),
              style: AppTextStyles.font16Bold(context)
                  .copyWith(color: AppColors.black),
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
            border: Border.all(color: AppColors.border, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(7, (dayIndex) {
              final bool isActiveSlot = activeSlots.contains(dayIndex);

              final Color circleColor = isActiveSlot
                  ? AppColors.primaryColor
                  : AppColors.primaryColor.withValues(alpha: 0.30);

              return Column(
                children: [
                  Text(
                    _dayLabels[dayIndex],
                    style: AppTextStyles.font12Medium(context)
                        .copyWith(color: AppColors.grey),
                  ),
                  6.verticalSpace,
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 38.w,
                    height: 38.h,
                    decoration: BoxDecoration(
                      color: circleColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${dayIndex + 1}',
                        style: AppTextStyles.font14Medium(context)
                            .copyWith(color: AppColors.background),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}
