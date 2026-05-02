import 'package:fitness/core/di/dependency_injection.dart';
import 'package:fitness/feature/home/domain/repo/workout_repo.dart';
import 'package:fitness/feature/home/ui/cubit/workout_cubit/workout_cubit.dart';
import 'package:fitness/feature/onboarding/domain/repo/onboarding_repo.dart';
import 'package:fitness/feature/onboarding/ui/cubit/onboarding_cubit.dart';
import 'package:mocktail/mocktail.dart';

class OnboardingMockRepo extends Mock implements OnboardingRepo {}
class WorkoutMockRepo extends Mock implements WorkoutRepo {}

late OnboardingMockRepo onboardingMockRepo;
late WorkoutMockRepo workoutMockRepo;

Future<void> setupOnboardingTest() async {
  await getIt.reset();
  onboardingMockRepo = OnboardingMockRepo();
  workoutMockRepo = WorkoutMockRepo();

  getIt.registerLazySingleton<OnboardingRepo>(() => onboardingMockRepo);
  getIt.registerLazySingleton<WorkoutRepo>(() => workoutMockRepo);
  getIt.registerFactory(() => OnboardingCubit(onboardingRepo: getIt<OnboardingRepo>()));
  getIt.registerFactory<WorkoutCubit>(() => WorkoutCubit(getIt<WorkoutRepo>()));
}