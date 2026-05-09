import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/workout_cubit/workout_cubit.dart';
import '../cubit/workout_cubit/workout_state.dart';
import 'custom_exercise_list_section.dart';

class CustomExerciseListSectionBlocBuilder extends StatelessWidget {
  const CustomExerciseListSectionBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutCubit, WorkoutState>(
      builder: (context, state) {
        if (state is WorkoutError) {
          return Text(state.message);
        }

        if (state is WorkoutSuccess) {
          return CustomExerciseListSection(
            dayExercise: state.dayExercises,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
