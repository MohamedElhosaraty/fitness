import 'package:fitness/core/helpers/firestore_service.dart';
import 'package:get_it/get_it.dart';

import '../../feature/auth/data/repo/auth_repo_impl.dart';
import '../../feature/auth/data/service/firebase_auth_service.dart';
import '../../feature/auth/domain/repos/auth_repo.dart';
import '../../feature/auth/ui/cubits/sign_in_cubit/signin_cubit.dart';
import '../../feature/auth/ui/cubits/signup_cubit/signup_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // 🔧 Core
  getIt.registerSingleton<FirebaseAuthServices>(FirebaseAuthServices());
  getIt.registerSingleton<FirestoreService>(FirestoreService());

  getIt.registerSingleton<AuthRepo>(
    AuthRepoImplemention(firebaseAuthServices: getIt<FirebaseAuthServices>(), firestore: getIt<FirestoreService>()),
  );

  // 🧠 Cubits
  getIt.registerFactory(() => SignupCubit(getIt<AuthRepo>()));
  getIt.registerFactory(() => SignInCubit(getIt<AuthRepo>()));

}
