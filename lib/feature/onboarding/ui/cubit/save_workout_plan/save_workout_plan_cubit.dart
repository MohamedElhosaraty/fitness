
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helpers/hive_helper.dart';
import '../../../../../core/helpers/user_preferences.dart';
import '../../../domain/repo/onboarding_repo.dart';

part 'save_workout_plan_state.dart';

class SaveWorkoutPlanCubit extends Cubit<SaveWorkoutPlanState> {
  SaveWorkoutPlanCubit( this.onboardingRepo) : super(SaveWorkoutPlanInitial());

  final OnboardingRepo onboardingRepo;

  Future<void> saveWorkoutPlan() async {
    emit(SaveWorkoutPlanLoading());

    final result = await onboardingRepo.getPlanWithExercises(UserPreferences.currentPlanId);

    result.fold(
          (failure) => emit(SaveWorkoutPlanFailure(failure.message)),
          (plan) async {
        await HiveHelper.savePlan(plan);
        emit(SaveWorkoutPlanSuccess());
      },
    );
  }
}
