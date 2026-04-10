import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/extensions.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../data/model/weekly_schedule_model.dart';
import 'custom_category_dropdown.dart';

class CustomDayCard extends StatefulWidget {
  const CustomDayCard({super.key,required this.day, required this.availableCategories});

  final DaySchedule day;
  final List<WorkoutCategory> availableCategories;

  @override
  State<CustomDayCard> createState() => _CustomDayCardState();
}

class _CustomDayCardState extends State<CustomDayCard> {

  late WorkoutCategory? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.day.category;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.day.dayName,
                style: AppTextStyles.font20Bold(context).copyWith(
                  color: AppColors.black,
                ),
              ),
              if (widget.day.isToday) ...[
                10.horizontalSpace,
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F0FC),
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
          ),
          12.verticalSpace,
          Text(
            'Category',
            style: AppTextStyles.font17Medium(context)
                .copyWith(color: AppColors.textSecondary),
          ),
          8.verticalSpace,
          CustomCategoryDropdown(
            selected: _selected,
            categories: widget.availableCategories,
            onChanged: (val) => setState(() => _selected = val),
          ),
          if (_selected != null) ...[
            12.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Exercises (${widget.day.exercises.length})',
                  style: AppTextStyles.font14Medium(context)
                      .copyWith(color: AppColors.textSecondary),
                ),
                TextButton(
                  onPressed: () {
                    context.pushNamed(Routes.selectExercisesView);
                  },
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Add',
                    style: AppTextStyles.font14Medium(context)
                        .copyWith(color: AppColors.primaryColor),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
