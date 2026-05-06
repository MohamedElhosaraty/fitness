import 'dart:async';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/app_config.dart';
import 'core/di/dependency_injection.dart';
import 'core/helpers/hive_helper.dart';
import 'core/helpers/shared_pref_helper.dart';
import 'core/observer/bloc_observer.dart';
import 'core/services/remote_config_service.dart';
import 'fitness.dart';

void runFitness(AppConfig appConfig) {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: appConfig.firebaseOptions,
    );
    await Firebase.initializeApp();
    await HiveHelper.init();

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    await Future.wait<void>([
      ScreenUtil.ensureScreenSize(),
      setupGetIt(),
      SharedPrefHelper.init(),
    ]);

    await getIt<RemoteConfigService>().init();
    Bloc.observer = MyBlocObserver();

    runApp(const Fitness());
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack, fatal: true));
}