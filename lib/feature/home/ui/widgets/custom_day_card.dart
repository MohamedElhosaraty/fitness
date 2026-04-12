import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/extensions.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../data/model/weekly_schedule_model.dart';
import '../cubit/get_day_exercises/get_day_exercises_cubit.dart';
import '../cubit/get_exercises/get_exercises_cubit.dart';
import 'custom_category_dropdown.dart';

class CustomDayCard extends StatefulWidget {
  const CustomDayCard({
    super.key,
    required this.day,
    required this.availableCategories,
    required this.splitType,
  });

  final DaySchedule day;
  final List<WorkoutCategory> availableCategories;
  final TrainingSplitType splitType;

  @override
  State<CustomDayCard> createState() => _CustomDayCardState();
}

class _CustomDayCardState extends State<CustomDayCard> {
  static final Map<String, Map<String, WorkoutCategory?>> _selectedMap = {};

  WorkoutCategory? get _selected =>
      _selectedMap[widget.splitType.name]?[widget.day.dayName];

  set _selected(WorkoutCategory? val) {
    _selectedMap[widget.splitType.name] ??= {};
    _selectedMap[widget.splitType.name]![widget.day.dayName] = val;
  }

  @override
  void initState() {
    super.initState();
    _selected ??= widget.day.category;
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
          _buildHeader(),
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
            _selected!.name.toLowerCase() == 'rest'
                ? _buildRestDay()
                : _buildExerciseList(),
          ],
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          widget.day.dayName,
          style: AppTextStyles.font20Bold(context)
              .copyWith(color: AppColors.black),
        ),
        if (widget.day.isToday) ...[
          10.horizontalSpace,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
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
    );
  }

  Widget _buildRestDay() {
    return Center(
      child: Column(
        children: [
          Text('😴', style: TextStyle(fontSize: 40.sp)),
          8.verticalSpace,
          Text(
            'Rest & Recovery Day',
            style: AppTextStyles.font14Medium(context)
                .copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseList() {
    return BlocBuilder<GetDayExercisesCubit, GetDayExercisesState>(
      builder: (context, state) {
        final exercises = state is GetDayExercisesSuccess
            ? state.day.exercises
            : widget.day.exercises;

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Exercises (${exercises.length})',
                  style: AppTextStyles.font14Medium(context)
                      .copyWith(color: AppColors.textSecondary),
                ),
                TextButton(
                  onPressed: _navigateToSelectExercises,
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    exercises.isEmpty ? 'Add' : 'Edit',
                    style: AppTextStyles.font14Medium(context)
                        .copyWith(color: AppColors.primaryColor),
                  ),
                ),
              ],
            ),
            if (exercises.isNotEmpty) ...[
              8.verticalSpace,
              ...exercises.map(
                    (e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      const Icon(Icons.fitness_center,
                          size: 16, color: Colors.grey),
                      8.horizontalSpace,
                      Text(
                        '${e.name} • 3 sets',
                        style: AppTextStyles.font14Medium(context)
                            .copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  void _navigateToSelectExercises() async {
    final cubit = context.read<GetExercisesCubit>();
    final dayCubit = context.read<GetDayExercisesCubit>();
    cubit.getExercises(_selected!.name);

    await context.pushNamed(
      Routes.selectExercisesView,
      arguments: {
        'cubit': cubit,
        'day': widget.day.copyWith(category: _selected),
      },
    );

    dayCubit.getDayExercises(dayName: widget.day.dayName);
  }
}