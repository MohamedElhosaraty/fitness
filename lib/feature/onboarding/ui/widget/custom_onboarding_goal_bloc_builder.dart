import 'package:fitness/feature/onboarding/ui/widget/custom_onboarding_goal_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/onboarding_cubit.dart';
import '../../../../core/widgets/custom_onboarding_goal_shimmer.dart';

class CustomOnboardingGoalBlocBuilder extends StatelessWidget {
  const CustomOnboardingGoalBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        if (state is OnboardingLoading) {
          return CustomListViewShimmer();
        }

        if (state is OnboardingError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (state is OnboardingSuccess) {
          final goals = state.goals;
          return CustomOnboardingGoalCard(goals: goals);
        }

        return const SizedBox.shrink();
      },
    );
  }
}
