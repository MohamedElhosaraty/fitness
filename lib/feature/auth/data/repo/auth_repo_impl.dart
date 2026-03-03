import 'dart:convert';
import 'dart:developer';
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
  final FirestoreService firestore ;
  AuthRepoImplemention( {required this.firebaseAuthServices,required this.firestore,});

  // ----------------- create user with email and password ------------------

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
      await addUserData(user: userModel);
      await saveUserData(user: userModel);

      return right(userModel);
    } on CustomException catch (e) {
      await deleteUser(user);
      return left(ServerFailure(e.message));
    } catch (e) {
      await deleteUser(user);
      return left(ServerFailure('An error occurred. Please try again.'));
    }
  }

  // ----------------- sign in with email and password ------------------

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

      var userModel = await getUserData(uId: user.uid);

      await saveUserData(user: userModel);

      return right(userModel);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure('An error occurred. Please try again.'));
    }
  }

  Future<void> deleteUser(User? user) async {
    if (user != null) {
      await firebaseAuthServices.deleteUser();
    }
  }

  @override
  Future addUserData({required UserModel user}) async {
    try {
      await firestore.addData(
          path: Constants.addUserData,
          data: user.toMap(),
          uid: user.uId);
    } catch (e) {
      log("Exception in AuthRepoImplemention.addUserData : ${e.toString()}");
      throw ServerFailure( e.toString());
    }
  }

  @override
  Future<UserModel> getUserData({required String uId}) async {
    try {
      final userData = await firestore.getData(
        path: Constants.getUserData,
        documentId: uId,
      );

      if (userData == null) {
        throw ServerFailure('User data not found');
      }
      return UserModel.fromMap(userData);

    } catch (e) {
      log("Exception in AuthRepoImplemention.getUserData : ${e.toString()}");
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future saveUserData({required UserModel user}) async{
    var jsonData = jsonEncode(user.toMap());
    await SharedPrefHelper.setString(Constants.kUserdata, jsonData);
  }
}
