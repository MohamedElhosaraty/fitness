import 'package:dartz/dartz.dart';
import 'package:fitness/feature/onboarding/data/model/onboarding_goal_model.dart';
import 'package:fitness/feature/onboarding/data/model/plan_model.dart';
import 'package:fitness/feature/onboarding/data/model/workout_exercise_model.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/helpers/firestore_service.dart';
import '../model/workout_day_model.dart';

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

  Future<Either<Failure, PlanModel>> getPlanWithExercises({
    required String planId,
  }) async {
    final planResult = await firestoreService.getData(
      path: 'plans',
      documentId: planId,
    );

    if (planResult.isLeft()) {
      return Left(planResult.fold((f) => f, (_) => throw Exception()));
    }

    final planData = planResult.getOrElse(() => {});

    final parsedDays = List<Map<String, dynamic>>.from(
      (planData['workout_days'] as List? ?? [])
          .map((d) => Map<String, dynamic>.from(d)),
    ).map((day) {
      final exercises = List<Map<String, dynamic>>.from(
        (day['workout_exercises'] as List? ?? [])
            .map((e) => Map<String, dynamic>.from(e)),
      );
      return (day: day, exercises: exercises);
    }).toList();

    final exerciseIds = <String>{
      for (final d in parsedDays)
        for (final ex in d.exercises)
          if ((ex['exercise_id'] as String?)?.isNotEmpty == true)
            ex['exercise_id'] as String,
    };

    final responses = await Future.wait(
      exerciseIds.map((id) => firestoreService.getData(
        path: 'exercises',
        documentId: id,
      )),
    );

    final exercisesMap = <String, Map<String, dynamic>>{
      for (int i = 0; i < exerciseIds.length; i++)
        if (responses[i].isRight())
          exerciseIds.elementAt(i): responses[i].getOrElse(() => {}),
    };

    final workoutDays = parsedDays.map((d) {
      final exercises = d.exercises.map((exMap) {
        final id = exMap['exercise_id'] as String? ?? '';
        return WorkoutExerciseModel.fromMerged(
          planExercise: exMap,
          exerciseData: exercisesMap[id] ?? const {},
        );
      }).toList();

      return WorkoutDayModel.withExercises(map: d.day, exercises: exercises);
    }).toList();

    return Right(PlanModel(
      planId: planData['plan_id'] ?? planId,
      goalId: planData['goal_id'] ?? '',
      availabilityDays: planData['availability_days'] ?? 0,
      workoutDays: workoutDays,
    ));
  }
}