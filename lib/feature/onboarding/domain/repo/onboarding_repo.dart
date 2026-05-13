import 'package:dartz/dartz.dart';
import 'package:fitness/feature/onboarding/data/model/plan_model.dart';
import '../../../../core/errors/failures.dart';
import '../../data/model/onboarding_goal_model.dart';

abstract class OnboardingRepo {
  Future<Either<Failure, List<OnboardingGoalModel>>> getOnboardingGoals();

  Future<Either<Failure, PlanModel>> getPlanWithExercises(
    String planId,
  );
}
