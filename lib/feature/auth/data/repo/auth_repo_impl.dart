import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/core/helpers/firestore_service.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/helpers/shared_pref_helper.dart';
import '../../../../core/networking/api_constants.dart';
import '../../domain/repos/auth_repo.dart';
import '../model/user_model.dart';
import '../service/firebase_auth_service.dart';

class AuthRepoImplemention extends AuthRepo {
  final FirebaseAuthServices firebaseAuthServices;
  final FirestoreService firestore;

  AuthRepoImplemention({
    required this.firebaseAuthServices,
    required this.firestore,
  });

  // ----------------- create user -----------------

  @override
  Future<Either<Failure, UserModel>> createUserWithEmailAndPassword(
      String email,
      String password,
      String name,
      String? image,
      ) async {
    User? user;
    try {
      user = await firebaseAuthServices.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      var userModel = UserModel(
        email: email,
        name: name,
        uId: user.uid,
        imageUrl: image,
      );

      final addResult = await addUserData(user: userModel);

      return addResult.fold(
            (failure) => Left(failure),
            (_) async {
          await saveUserData(user: userModel);
          return Right(userModel);
        },
      );
    } on CustomException catch (e) {
      await deleteUser(user);
      return Left(ServerFailure(e.message));
    } catch (e) {
      await deleteUser(user);
      return Left(ServerFailure('An error occurred. Please try again.'));
    }
  }

  // ----------------- sign in -----------------

  @override
  Future<Either<Failure, UserModel>> signInWithEmailAndPassword(
      String email,
      String password,
      ) async {
    try {
      var user = await firebaseAuthServices.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final result = await getUserData(uId: user.uid);

      return result.fold(
            (failure) => Left(failure),
            (userModel) async {
          await saveUserData(user: userModel);
          return Right(userModel);
        },
      );
    } on CustomException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('An error occurred. Please try again.'));
    }
  }

  // ----------------- add user data -----------------

  @override
  Future<Either<Failure, void>> addUserData({required UserModel user}) async {
    final result = await firestore.addData(
      path: Constants.addUserData,
      data: user.toMap(),
      uid: user.uId,
    );

    return result.fold(
          (failure) => Left(failure),
          (_) => Right(null),
    );
  }

  // ----------------- get user data -----------------

  @override
  Future<Either<Failure, UserModel>> getUserData({required String uId}) async {
    final result = await firestore.getData(
      path: Constants.getUserData,
      documentId: uId,
    );

    return result.fold(
          (failure) => Left(failure),
          (userData) {
        try {
          return Right(UserModel.fromMap(userData));
        } catch (e) {
          return Left(ServerFailure(e.toString()));
        }
      },
    );
  }

  // ----------------- save user data -----------------

  @override
  Future saveUserData({required UserModel user}) async {
    var jsonData = jsonEncode(user.toMap());
    await SharedPrefHelper.setString(Constants.kUserdata, jsonData);
  }

  // ----------------- delete user -----------------

  Future<void> deleteUser(User? user) async {
    if (user != null) {
      await firebaseAuthServices.deleteUser();
    }
  }
}