import 'package:fitness/feature/home/ui/widget/custom_content_active_plan_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theming/app_colors.dart';
import '../cubit/workout_cubit/workout_cubit.dart';
import '../cubit/workout_cubit/workout_state.dart';
import 'custom_content_active_shimmer.dart';

class CustomContentBlocBuilderActivePlan extends StatelessWidget {
  const CustomContentBlocBuilderActivePlan({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutCubit , WorkoutState>(
      builder: (context, state) {
        if(state is WorkoutLoading){
          return CustomContentActiveShimmer();
        }
        if(state is WorkoutError){
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: AppColors.red),
            ),
          );
        }
        if(state is WorkoutSuccess){
          return CustomContentActivePlanCard(
              dayExerciseModel: state.dayExercises);
        }
        return SizedBox.shrink  ();
      },
    );
  }
}
