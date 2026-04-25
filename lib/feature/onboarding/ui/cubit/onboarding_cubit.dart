
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/onboarding_goal_model.dart';
import '../../domain/repo/onboarding_repo.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({required this.onboardingRepo}) : super(OnboardingInitial());

  final OnboardingRepo onboardingRepo;

  Future<void> getOnboardingGoals() async {
    emit(OnboardingLoading());

    final result = await onboardingRepo.getOnboardingGoals();

    result.fold(
          (failure) => emit(OnboardingError(failure.message)),
          (goals) => emit(OnboardingSuccess(goals: goals)),
    );
  }
}
