import 'package:fitness/core/helpers/firestore_service.dart';
import 'package:fitness/feature/home/ui/cubit/add_exercises/add_exercises_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../feature/auth/data/repo/auth_repo_impl.dart';
import '../../feature/auth/data/service/firebase_auth_service.dart';
import '../../feature/auth/domain/repos/auth_repo.dart';
import '../../feature/auth/ui/cubits/sign_in_cubit/signin_cubit.dart';
import '../../feature/auth/ui/cubits/signup_cubit/signup_cubit.dart';
import '../../feature/home/data/repo/workout_repo_impl.dart';
import '../../feature/home/data/service/firebase_workout_service.dart';
import '../../feature/home/domain/repos/workout_repo.dart';
import '../../feature/home/ui/cubit/get_all_day_exercises/get__all_day_exercises_cubit.dart';
import '../../feature/home/ui/cubit/get_exercises/get_exercises_cubit.dart';
import '../../feature/onboarding/data/repo/onboarding_repo_impl.dart';
import '../../feature/onboarding/data/service/firestore_onboarding_service.dart';
import '../../feature/onboarding/domain/repo/onboarding_repo.dart';
import '../../feature/onboarding/ui/cubit/onboarding_cubit.dart';
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

  // 💪 Workout
  getIt.registerSingleton<FirebaseWorkoutService>(
    FirebaseWorkoutService(getIt<FirestoreService>()),
  );

  getIt.registerSingleton<WorkoutRepo>(
    WorkoutRepoImpl(
      getIt<FirebaseWorkoutService>(),
      getIt<RemoteConfigService>(),
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


  // 🧠 Cubits
  getIt.registerFactory(() => SignupCubit(getIt<AuthRepo>()));
  getIt.registerFactory(() => SignInCubit(getIt<AuthRepo>()));
  getIt.registerFactory(() => GetExercisesCubit(getIt<WorkoutRepo>(),));
  getIt.registerFactory(() => AddExercisesCubit(getIt<WorkoutRepo>()));
  getIt.registerFactory(() => GetAllDayExercisesCubit(getIt<WorkoutRepo>()));
  getIt.registerFactory(() => OnboardingCubit(onboardingRepo: getIt<OnboardingRepo>()));

}