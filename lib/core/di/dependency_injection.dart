import 'package:fitness/core/helpers/firestore_service.dart';
import 'package:get_it/get_it.dart';

import '../../feature/home/ui/cubit/workout_cubit/workout_cubit.dart';
import '../../feature/onboarding/data/repo/onboarding_repo_impl.dart';
import '../../feature/onboarding/data/service/firestore_onboarding_service.dart';
import '../../feature/onboarding/domain/repo/onboarding_repo.dart';
import '../../feature/onboarding/ui/cubit/onboarding_cubit.dart';
import '../../feature/onboarding/ui/cubit/save_workout_plan/save_workout_plan_cubit.dart';
import '../localization/cubit/localization_cubit.dart';
import '../services/remote_config_service.dart';


final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // 🔧 Core
  getIt.registerSingleton<FirestoreService>(FirestoreService());
  getIt.registerLazySingleton(() => RemoteConfigService());

  // 🎯 Onboarding
  getIt.registerSingleton<FirestoreOnboardingService>(
    FirestoreOnboardingService(firestoreService: getIt<FirestoreService>()),
  );

  getIt.registerSingleton<OnboardingRepo>(
    OnboardingRepoImpl(
      onboardingService: getIt<FirestoreOnboardingService>(),
    ),
  );


  // 🧠 Cubits
  getIt.registerFactory(() => OnboardingCubit(onboardingRepo: getIt<OnboardingRepo>()));
  getIt.registerFactory(() => LocalizationCubit());
  getIt.registerFactory(() => WorkoutCubit());
  getIt.registerFactory(() => SaveWorkoutPlanCubit(getIt<OnboardingRepo>()));


}