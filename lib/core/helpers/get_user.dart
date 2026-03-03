import 'dart:convert';
import 'package:fitness/core/helpers/shared_pref_helper.dart';

import '../../feature/auth/data/model/user_model.dart';
import '../networking/api_constants.dart';


UserModel getUser(){
  var jsonString = SharedPrefHelper.getString(Constants.kUserdata);
  var userModel = UserModel.fromMap(json.decode(jsonString));

  return userModel;
}

