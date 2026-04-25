import 'package:dartz/dartz.dart';
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
}