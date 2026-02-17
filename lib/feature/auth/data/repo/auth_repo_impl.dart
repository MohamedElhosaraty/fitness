import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/helpers/shared_pref_helper.dart';
import '../../../../core/networking/api_constants.dart';
import '../../domain/entites/user_entity.dart';
import '../../domain/repos/auth_repo.dart';
import '../../model/user_model.dart';
import '../service/firebase_auth_service.dart';

class AuthRepoImplemention extends AuthRepo {
  final FirebaseAuthServices firebaseAuthServices;

  AuthRepoImplemention(
      {required this.firebaseAuthServices});



  // ----------------- create user with email and password ------------------

  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    User? user;
    try {
      user = await firebaseAuthServices.createUserWithEmailAndPassword(
          email: email, password: password);
      var userEntity = UserEntity(email: email, name: name, uId: user.uid);
      await saveUserData(user: userEntity);

      return right(
        userEntity,
      );
    } on CustomException catch (e) {
      await deleteUser(user);
      return left(
        ServerFailure(e.message),
      );
    } catch (e) {
      await deleteUser(user);
      return left(
        ServerFailure('An error occurred. Please try again.'),
      );
    }
  }


  // ----------------- sign in with email and password ------------------


  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      var user = await firebaseAuthServices.signInWithEmailAndPassword(
          email: email, password: password);

      var userEntity =  UserEntity(email: email, name: user.displayName ?? '', uId: user.uid);
      await saveUserData(user: userEntity);

      return right(
        userEntity,
      );
    } on CustomException catch (e) {
      return left(
        ServerFailure(e.message),
      );
    } catch (e) {
      // بعملها جوة ال exception لى انت مش عمله
      log("Exception in AuthRepoImplemention.createUserWithEmailAndPassword : ${e.toString()}");
      return left(
        ServerFailure('لقد حدث خطأ. الرجاء المحاولة مرة أخرى.'),
      );
    }
  }


  // ----------------- get user data ------------------


  Future<void> deleteUser(User? user) async {
    if (user != null) {
      await firebaseAuthServices.deleteUser();
    }
  }

  // ----------------- save user data ------------------

  @override
  Future saveUserData({required UserEntity user}) async{
    var jsonData = jsonEncode(UserModel.fromEntity(user).toMap());
    await SharedPrefHelper.setData(Constants.kUserdata, jsonData);
  }
}