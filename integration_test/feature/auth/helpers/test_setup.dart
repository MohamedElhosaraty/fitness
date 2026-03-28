import 'package:fitness/core/di/dependency_injection.dart';
import 'package:fitness/feature/auth/domain/repos/auth_repo.dart';
import 'package:fitness/feature/auth/ui/cubits/sign_in_cubit/signin_cubit.dart';
import 'package:fitness/feature/auth/ui/cubits/signup_cubit/signup_cubit.dart';
import 'package:mocktail/mocktail.dart';

class AuthMockRepo extends Mock implements AuthRepo {}

late AuthMockRepo authMockRepo;

Future<void> setupAuthTest() async {
  await getIt.reset();
  authMockRepo = AuthMockRepo();
  getIt.registerLazySingleton<AuthRepo>(() => authMockRepo);
  getIt.registerFactory(() => SignInCubit(getIt<AuthRepo>()));
  getIt.registerFactory(() => SignupCubit(getIt<AuthRepo>()));
}