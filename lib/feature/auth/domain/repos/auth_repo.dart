import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../data/model/user_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserModel>> createUserWithEmailAndPassword(
    String email,
    String password,
    String name,
    String? image,
  );

  Future<Either<Failure, UserModel>> signInWithEmailAndPassword(
    String email,
    String password,
  );

  Future addUserData({
    required UserModel user,
  });

  Future<Either<Failure,UserModel>> getUserData({required String uId});
  Future saveUserData({required UserModel user});
}
