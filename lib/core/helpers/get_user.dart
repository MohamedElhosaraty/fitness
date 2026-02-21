import 'dart:convert';

import 'package:fitness/core/helpers/shared_pref_helper.dart';

import '../../feature/auth/data/model/user_model.dart';
import '../networking/api_constants.dart';

Future<UserModel> getUser() async {
  var jsonString =
  await SharedPrefHelper.getString(Constants.kUserdata);

  var userEntity =
  UserModel.fromJson(jsonDecode(jsonString));

  return userEntity;
}