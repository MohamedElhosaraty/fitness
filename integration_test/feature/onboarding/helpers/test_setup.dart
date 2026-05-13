import 'package:fitness/core/di/dependency_injection.dart';
import 'package:fitness/core/networking/api_constants.dart';
import 'package:fitness/feature/home/ui/cubit/workout_cubit/workout_cubit.dart';
import 'package:fitness/feature/onboarding/data/model/plan_model.dart';
import 'package:fitness/feature/onboarding/data/model/workout_day_model.dart';
import 'package:fitness/feature/onboarding/data/model/workout_exercise_model.dart';
import 'package:fitness/feature/onboarding/domain/repo/onboarding_repo.dart';
import 'package:fitness/feature/onboarding/ui/cubit/onboarding_cubit.dart';
import 'package:fitness/feature/onboarding/ui/cubit/save_workout_plan/save_workout_plan_cubit.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mocktail/mocktail.dart';

class OnboardingMockRepo extends Mock implements OnboardingRepo {}

late OnboardingMockRepo onboardingMockRepo;

Future<void> setupOnboardingTest() async {
  await getIt.reset();

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(1)) Hive.registerAdapter(WorkoutExerciseModelAdapter());
  if (!Hive.isAdapterRegistered(2)) Hive.registerAdapter(WorkoutDayModelAdapter());
  if (!Hive.isAdapterRegistered(3)) Hive.registerAdapter(PlanModelAdapter());

  final box = await Hive.openBox<PlanModel>(Constants.planBox);
  await box.clear();

  onboardingMockRepo = OnboardingMockRepo();
  getIt.registerLazySingleton<OnboardingRepo>(() => onboardingMockRepo);
  getIt.registerFactory(() => OnboardingCubit(onboardingRepo: getIt<OnboardingRepo>()));
  getIt.registerFactory<WorkoutCubit>(() => WorkoutCubit());
  getIt.registerFactory<SaveWorkoutPlanCubit>(
        () => SaveWorkoutPlanCubit(getIt<OnboardingRepo>()),
  );
}