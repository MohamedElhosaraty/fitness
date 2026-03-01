import 'dart:convert';
import 'package:fitness/core/helpers/shared_pref_helper.dart';

import '../../feature/auth/data/model/user_model.dart';
import '../networking/api_constants.dart';

UserModel? getUser() {
  try {
    final jsonString = SharedPrefHelper.getString(Constants.kUserdata);
    final Map<String, dynamic> userMap = jsonDecode(jsonString);

    final user = UserModel.fromMap(userMap);
    return user;
  } catch (e) {
    return null;
  }
}

