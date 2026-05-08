import 'package:fitness/feature/onboarding/ui/widget/custom_onboarding_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/dependency_injection.dart';
import '../cubit/onboarding_cubit.dart';
import '../cubit/save_workout_plan/save_workout_plan_cubit.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          getIt<OnboardingCubit>()
            ..getOnboardingGoals(),
        ),
        BlocProvider(
          create: (context) => getIt<SaveWorkoutPlanCubit>(),
        ),
      ],
      child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          body: OnboardingScreenBody()),
    );
  }
}
