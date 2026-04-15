import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/extensions.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../data/model/day_schedule_model.dart';
import '../../domain/entity/workout_category.dart';
import '../cubit/get_day_exercises/get_day_exercises_cubit.dart';
import '../cubit/get_exercises/get_exercises_cubit.dart';

class CustomExerciseListDayCardBlocBuilder extends StatelessWidget {
  const CustomExerciseListDayCardBlocBuilder({super.key, required this.day,required WorkoutCategory? selected}) : _selected = selected;

  final DayScheduleModel day;
  final WorkoutCategory? _selected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetDayExercisesCubit, GetDayExercisesState>(
      builder: (context, state) {
        final exercises = state is GetDayExercisesSuccess
            ? state.day.exercises
            : day.exercises;
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
                  onPressed: ()async{
                    final cubit = context.read<GetExercisesCubit>();
                    final currentState = context.read<GetDayExercisesCubit>().state;
                    final alreadySelected = currentState is GetDayExercisesSuccess
                        ? currentState.day.exercises
                        : day.exercises;

                    cubit.getExercises(
                      _selected!.name,
                      selectedExercises: alreadySelected,
                    );
                    await context.pushNamed(
                      Routes.selectExercisesView,
                      arguments: {
                        'cubit': cubit,
                        'day': day.copyWith(category: _selected),
                      },
                    );
                  },
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
}

