import 'package:dartz/dartz.dart';
import 'package:fitness/feature/onboarding/data/model/plan_model.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repo/onboarding_repo.dart';
import '../model/onboarding_goal_model.dart';
import '../service/firestore_onboarding_service.dart';

class OnboardingRepoImpl implements OnboardingRepo {
  final FirestoreOnboardingService onboardingService;

  OnboardingRepoImpl({required this.onboardingService});

  @override
  Future<Either<Failure, List<OnboardingGoalModel>>> getOnboardingGoals() async {
    return await onboardingService.getOnboardingGoals();
  }

  @override
  Future<Either<Failure, PlanModel>> getPlanWithExercises(
      String planId,
      ) =>
      onboardingService.getPlanWithExercises(planId: planId);
}