import 'package:fitness/feature/home/ui/widgets/custom_exercise_list_day_card_bloc_builder.dart';
import 'package:fitness/feature/home/ui/widgets/custom_header_day_card.dart';
import 'package:fitness/feature/home/ui/widgets/custom_rest_day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../data/model/day_schedule_model.dart';
import '../../domain/entity/training_split_type.dart';
import '../../domain/entity/workout_category.dart';
import '../cubit/get_all_day_exercises/get__all_day_exercises_cubit.dart';
import 'custom_category_dropdown.dart';

class CustomDayCard extends StatefulWidget {
  const CustomDayCard({
    super.key,
    required this.day,
    required this.availableCategories,
    required this.splitType,
  });

  final DayScheduleModel day;
  final List<WorkoutCategory> availableCategories;
  final TrainingSplitType splitType;

  @override
  State<CustomDayCard> createState() => _CustomDayCardState();
}

class _CustomDayCardState extends State<CustomDayCard> {
  WorkoutCategory? _selected;

  @override
  void initState() {
    super.initState();
    final state = context.read<GetAllDayExercisesCubit>().state;
    if (state is GetAllDayExercisesSuccess) {
      final day = state.listDays.firstWhere(
            (d) => d.dayName == widget.day.dayName,
        orElse: () => widget.day,
      );
      _selected = day.category ?? widget.day.category;
    } else {
      _selected = widget.day.category;
    }
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
          CustomHeaderDayCard(
              day: widget.day),
          12.verticalSpace,
          Text(
            'Category',
            style: AppTextStyles.font17Medium(context)
                .copyWith(color: AppColors.textSecondary),
          ),
          8.verticalSpace,
          CustomCategoryDropdown(
            selected: _selected,
            categories: [
              if (_selected != null && !widget.availableCategories.contains(_selected))
                _selected!,
              ...widget.availableCategories,
            ],
            onChanged: (val) {
              setState(() => _selected = val);
              if (val != null && val.name.toLowerCase() == 'rest') {
                context.read<GetAllDayExercisesCubit>().updateDayToRest(
                  widget.day.copyWith(category: val),
                );
              }
            },
          ),
          if (_selected != null) ...[
            12.verticalSpace,
            _selected!.name.toLowerCase() == 'rest'
                ? CustomRestDay()
                : CustomExerciseListDayCardBlocBuilder(
                day: widget.day,
                selected: _selected,
            ),
          ],
        ],
      ),
    );
  }


}