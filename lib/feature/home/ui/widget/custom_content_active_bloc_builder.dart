import 'package:fitness/feature/home/ui/widget/custom_content_active_plan_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/workout_cubit/workout_cubit.dart';
import '../cubit/workout_cubit/workout_state.dart';

class CustomContentActiveBlocBuilder extends StatelessWidget {
  const CustomContentActiveBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutCubit, WorkoutState>(
      builder: (context, state) {
        if (state is WorkoutError) {
          return Text(state.message);
        }

        if (state is WorkoutSuccess) {
          return CustomContentActivePlanCard(
            dayExerciseModel: state.dayExercises,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
