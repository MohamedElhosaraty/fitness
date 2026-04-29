import 'package:fitness/core/helpers/firestore_service.dart';
import 'package:get_it/get_it.dart';

import '../../feature/auth/data/repo/auth_repo_impl.dart';
import '../../feature/auth/data/service/firebase_auth_service.dart';
import '../../feature/auth/domain/repos/auth_repo.dart';
import '../../feature/auth/ui/cubits/sign_in_cubit/signin_cubit.dart';
import '../../feature/auth/ui/cubits/signup_cubit/signup_cubit.dart';
import '../../feature/home/data/repos/workout_repo_impl.dart';
import '../../feature/home/data/service/firestore_workout_service.dart';
import '../../feature/home/domain/repo/workout_repo.dart';
import '../../feature/home/ui/cubit/workout_cubit/workout_cubit.dart';
import '../../feature/onboarding/data/repo/onboarding_repo_impl.dart';
import '../../feature/onboarding/data/service/firestore_onboarding_service.dart';
import '../../feature/onboarding/domain/repo/onboarding_repo.dart';
import '../../feature/onboarding/ui/cubit/onboarding_cubit.dart';
import '../localization/cubit/localization_cubit.dart';
import '../services/remote_config_service.dart';


final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // 🔧 Core
  getIt.registerSingleton<FirebaseAuthServices>(FirebaseAuthServices());
  getIt.registerSingleton<FirestoreService>(FirestoreService());
  getIt.registerLazySingleton(() => RemoteConfigService());
  // 🔐 Auth
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImplemention(
      firebaseAuthServices: getIt<FirebaseAuthServices>(),
      firestore: getIt<FirestoreService>(),
    ),
  );

  // 🎯 Onboarding
  getIt.registerSingleton<FirestoreOnboardingService>(
    FirestoreOnboardingService(firestoreService: getIt<FirestoreService>()),
  );

  getIt.registerSingleton<OnboardingRepo>(
    OnboardingRepoImpl(
      onboardingService: getIt<FirestoreOnboardingService>(),
    ),
  );

// 🏋️ Workout
  getIt.registerSingleton<FirestoreWorkoutService>(
    FirestoreWorkoutService(getIt<FirestoreService>()),
  );

  getIt.registerSingleton<WorkoutRepo>(
    WorkoutRepoImpl(getIt<FirestoreWorkoutService>()),
  );

  // 🧠 Cubits
  getIt.registerFactory(() => SignupCubit(getIt<AuthRepo>()));
  getIt.registerFactory(() => SignInCubit(getIt<AuthRepo>()));
  getIt.registerFactory(() => OnboardingCubit(onboardingRepo: getIt<OnboardingRepo>()));
  getIt.registerFactory(() => LocalizationCubit());
  getIt.registerFactory(() => WorkoutCubit(getIt<WorkoutRepo>()));


}