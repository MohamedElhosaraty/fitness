import 'dart:convert';
import 'package:fitness/core/helpers/shared_pref_helper.dart';
import '../../feature/auth/data/model/user_model.dart';
import '../networking/api_constants.dart';

UserModel getUser() {
  var jsonString = SharedPrefHelper.getString(Constants.kUserdata);

  if (jsonString.isNotEmpty) {
    return UserModel.fromMap(json.decode(jsonString));
  }
      return UserModel(
          name: "Mohamed",
          email: "guest@example.com",
          uId: "0",
          imageUrl: "https://cdn-icons-png.flaticon.com/512/149/149071.png"
      );
    }
