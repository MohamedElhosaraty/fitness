import 'package:firebase_core/firebase_core.dart';

enum AppEnvironment {
  development,
  production,
  staging,
}
class AppConfig {
  final AppEnvironment appEnvironment;
  final FirebaseOptions firebaseOptions;
  AppConfig({required this.appEnvironment,required this.firebaseOptions, });
}