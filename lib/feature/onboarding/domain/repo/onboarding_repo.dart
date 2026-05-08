import 'package:dartz/dartz.dart';
import 'package:fitness/feature/onboarding/data/model/day_exercise_model.dart';
import '../../../../core/errors/failures.dart';
import '../../data/model/onboarding_goal_model.dart';

abstract class OnboardingRepo {
  Future<Either<Failure, List<OnboardingGoalModel>>> getOnboardingGoals();

  Future<Either<Failure, Map<String, DayExerciseModel>>> getAllDaysExercises(
    String goal,
    int numberDays,
  );
}
