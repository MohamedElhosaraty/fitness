import 'package:fitness/run_fitness.dart';

import 'config/app_config.dart';
import 'firebase_options_prod.dart';

void main() {
  AppConfig appConfig = AppConfig(
    firebaseOptions: DefaultFirebaseOptions.currentPlatform,
    appEnvironment: AppEnvironment.production,
  );

  runFitness(appConfig);
}
