import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String email;
  final String name;
  final String uId;

  UserModel({
    required this.email,
    required this.name,
    required this.uId,
  });
  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      email: user.email ?? "",
      name: user.displayName ?? "",
      uId: user.uid,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    email: json["email"],
    name: json["name"],
    uId: json["uId"],
  );


  toMap() {
    return {'name': name, 'email': email, 'uId': uId};
  }
}