import 'package:fitness/core/widgets/custom_onboarding_goal_shimmer.dart';
import 'package:fitness/feature/home/ui/widget/custom_exercise_list_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/workout_cubit/workout_cubit.dart';
import '../cubit/workout_cubit/workout_state.dart';

class CustomExerciseBlocBuilder extends StatelessWidget {
  const CustomExerciseBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutCubit, WorkoutState>(
      builder: (context, state) {
        if(state is WorkoutLoading){
          return const CustomListViewShimmer();
        }
        if(state is WorkoutError){
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        if(state is WorkoutSuccess){
          return CustomExerciseListSection(
            dayExercise: state.dayExercises,);
        }
        return SizedBox.shrink();
      },
    );
  }
}
