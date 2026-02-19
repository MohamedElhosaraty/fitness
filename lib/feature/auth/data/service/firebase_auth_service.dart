import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/errors/exceptions.dart';

class FirebaseAuthServices {

  /// ------------------ create user with email and password ------------------
  Future<User> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw CustomException(
            message: 'The Password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw CustomException(
            message:
            'The account already exists for that email.');
      } else if (e.code == "network-request-failed") {
        throw CustomException(
            message: "No internet connection. Please try again.");
      } else if (e.code == "invalid-email") {
        throw CustomException(
            message: "The email address is not valid.");
      } else {
        throw CustomException(
            message: "An error occurred. Please try again.");
      }
    } catch (e) {
        throw CustomException(
          message: "An error occurred. Please try again.");
    }
  }

  //-------- sign in with email and password -------

  Future<User> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw CustomException(
            message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw CustomException(
            message: 'The password is incorrect.');
      } else if (e.code == "network-request-failed") {
        throw CustomException(
            message: "No internet connection. Please try again.");
      } else if (e.code == "invalid-email") {
        throw CustomException(
            message: "The email address is not valid.");
      } else {
        throw CustomException(
            message: "An error occurred. Please try again.");
      }
    } catch (e) {
      throw CustomException(
          message: "An error occurred. Please try again.");
    }
  }

  Future<void> deleteUser() async {
    await FirebaseAuth.instance.currentUser!.delete();
  }

  bool isLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }
}