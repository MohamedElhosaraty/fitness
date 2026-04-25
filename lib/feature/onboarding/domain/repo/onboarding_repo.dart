import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../data/model/onboarding_goal_model.dart';

abstract class OnboardingRepo {
  Future<Either<Failure, List<OnboardingGoalModel>>> getOnboardingGoals();
}