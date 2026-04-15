import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/app_config.dart';
import 'core/di/dependency_injection.dart';
import 'core/helpers/shared_pref_helper.dart';
import 'core/observer/bloc_observer.dart';
import 'core/services/remote_config_service.dart';
import 'fitness.dart';

void runFitness(AppConfig appConfig) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: appConfig.firebaseOptions,
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  await Future.wait<void>([ScreenUtil.ensureScreenSize(),  setupGetIt() , SharedPrefHelper.init()]);
  await getIt<RemoteConfigService>().init();
  Bloc.observer = MyBlocObserver();
  runApp(const Fitness());
}
