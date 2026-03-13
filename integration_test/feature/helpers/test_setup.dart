import 'package:firebase_core/firebase_core.dart';
import 'package:fitness/core/di/dependency_injection.dart';
import 'package:fitness/core/helpers/shared_pref_helper.dart';
import 'package:fitness/feature/auth/domain/repos/auth_repo.dart';
import 'package:mocktail/mocktail.dart';

class AuthMockRepo extends Mock implements AuthRepo {}

late AuthMockRepo authMockRepo;

Future<void> setupAuthTest() async {
  await Firebase.initializeApp();
  SharedPrefHelper.init();

  await getIt.reset();
  setupGetIt();

  getIt.unregister<AuthRepo>();

  authMockRepo = AuthMockRepo();
  getIt.registerLazySingleton<AuthRepo>(() => authMockRepo);
}