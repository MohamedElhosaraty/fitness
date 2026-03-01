import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/helpers/shared_pref_helper.dart';
import '../../../../core/networking/api_constants.dart';
import '../../domain/repos/auth_repo.dart';
import '../model/user_model.dart';
import '../service/firebase_auth_service.dart';

class AuthRepoImplemention extends AuthRepo {
  final FirebaseAuthServices firebaseAuthServices;

  AuthRepoImplemention({required this.firebaseAuthServices});

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

      UserModel? localUser = _checkUserInCollection(user.uid);

      UserModel userModel;

      if (localUser != null) {
        userModel = localUser;
      } else {
        userModel = UserModel(
          email: email,
          name: user.displayName ?? '',
          uId: user.uid,
          imageUrl: user.photoURL,
        );
      }

      await saveUserData(user: userModel);

      return right(userModel);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure('An error occurred. Please try again.'));
    }
  }

  UserModel? _checkUserInCollection(String uId) {
    final String allUsersJson = SharedPrefHelper.getString("users_collection");
    if (allUsersJson.isNotEmpty) {
      Map<String, dynamic> usersMap = jsonDecode(allUsersJson);
      if (usersMap.containsKey(uId)) {
        return UserModel.fromMap(usersMap[uId]);
      }
    }
    return null;
  }

  // ----------------- delete user data ------------------

  Future<void> deleteUser(User? user) async {
    if (user != null) {
      await firebaseAuthServices.deleteUser();
    }
  }

  // ----------------- save user data ------------------

  @override
  Future<void> saveUserData({required UserModel user}) async {
    final String? allUsersJson = SharedPrefHelper.getString("users_collection");

    Map<String, dynamic> usersMap = {};

    if (allUsersJson != null && allUsersJson.isNotEmpty) {
      usersMap = jsonDecode(allUsersJson);
    }

    usersMap[user.uId] = user.toMap();

    await SharedPrefHelper.setString("users_collection", jsonEncode(usersMap));

    await SharedPrefHelper.setString(
      Constants.kUserdata,
      jsonEncode(user.toMap()),
    );
  }
}
