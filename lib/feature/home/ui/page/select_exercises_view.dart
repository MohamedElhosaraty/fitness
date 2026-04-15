import 'package:fitness/feature/home/ui/widgets/custom_exercise_card.dart';
import 'package:fitness/feature/home/ui/widgets/custom_select_exercises_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/model/day_schedule_model.dart';
import '../cubit/get_exercises/get_exercises_cubit.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_select_button_bloc_builder.dart';

class SelectExercisesView extends StatelessWidget {
  const SelectExercisesView({super.key, required this.daySchedule});

  final DayScheduleModel daySchedule;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: BlocBuilder<GetExercisesCubit, GetExercisesState>(
          builder: (context, state) {
            if (state is GetExercisesLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is GetExercisesError) {
              return Center(child: Text(state.message));
            }
            if (state is GetExercisesSuccess) {
              final exercises = state.exercises;
              final selectedCount = exercises.where((e) => e.isSelected).length;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const CustomAppBar(title: "Select Exercises"),
                    CustomSelectExercisesHeader(
                      selectedCount: selectedCount,
                      daySchedule: daySchedule,
                    ),
                    16.verticalSpace,
                    Expanded(
                      child: ListView.separated(
                        itemCount: exercises.length,
                        separatorBuilder: (_, __) => 12.verticalSpace,
                        itemBuilder: (context, index) {
                          final exercise = exercises[index];
                          return CustomExercisesCard(
                            exercise: exercise,
                            onTap: () {
                              context
                                  .read<GetExercisesCubit>()
                                  .toggleExercise(exercise);
                            },
                          );
                        },
                      ),
                    ),
                    20.verticalSpace,
                    if (selectedCount > 0)
                      CustomSelectButtonBlocBuilder(
                        exercises: exercises,
                        daySchedule: daySchedule,
                        selectedCount: selectedCount,
                      ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}