import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entites/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.email, required super.name, required super.uId});

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

  factory UserModel.fromEntity(UserEntity user) => UserModel(
    email: user.email,
    name: user.name,
    uId: user.uId,
  );

  toMap() {
    return {'name': name, 'email': email, 'uId': uId};
  }
}