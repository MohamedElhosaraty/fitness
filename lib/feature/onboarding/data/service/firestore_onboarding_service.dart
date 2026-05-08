import 'package:dartz/dartz.dart';
import 'package:fitness/feature/onboarding/data/model/day_exercise_model.dart';
import 'package:fitness/feature/onboarding/data/model/exercise_model.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/helpers/firestore_service.dart';
import '../model/onboarding_goal_model.dart';

class FirestoreOnboardingService {
  final FirestoreService firestoreService;

  FirestoreOnboardingService({required this.firestoreService});

  Future<Either<Failure, List<OnboardingGoalModel>>> getOnboardingGoals() async {
    final result = await firestoreService.getCollection(
      path: 'onboardingGoal',
    );

    return result.fold(
          (failure) => Left(failure),
          (data) {
        final goals = data
            .map((map) => OnboardingGoalModel.fromMap(map, map['id'] ?? ''))
            .toList();
        return Right(goals);
      },
    );
  }

  Future<Either<Failure, DayExerciseModel>> getDayExercises(
      String goal,
      int days,
      int indexDay,
      ) async {
    final planId = '$goal${days}Days';
    final dayId  = 'day$indexDay';

    final dayResult = await firestoreService.getData(
      path: 'workoutPlans/$planId/schedule',
      documentId: dayId,
    );

    return dayResult.fold(
          (failure) => Left(failure),
          (data) async {
        final refs = List<String>.from(data['exerciseRefs'] ?? []);

        final snapshots = await Future.wait(
          refs.map((ref) => firestoreService.getData(
            path: 'allExercises',
            documentId: ref,
          )),
        );

        final exercises = snapshots
            .where((e) => e.isRight())
            .map((e) => e.getOrElse(() => {}))
            .map((exerciseData) => ExerciseModel.fromMap(exerciseData))
            .toList();

        return Right(DayExerciseModel.fromMap(data, exercises));
      },
    );
  }

  Future<Either<Failure, Map<String, DayExerciseModel>>> getAllDaysExercises(
      String goal,
      int days,
      ) async {
    try {
      final results = await Future.wait(
        List.generate(
          days,
              (index) => getDayExercises(goal, days, index + 1),
        ),
      );

      final allDays = <String, DayExerciseModel>{};
      for (int i = 0; i < results.length; i++) {
        results[i].fold(
              (failure) => throw Exception(failure.message),
              (day) => allDays['day${i + 1}'] = day,
        );
      }

      return Right(allDays);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}