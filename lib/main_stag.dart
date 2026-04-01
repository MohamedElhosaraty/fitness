import 'package:fitness/run_fitness.dart';

import 'config/app_config.dart';
import 'firebase_options_staging.dart';

void main() {
  AppConfig appConfig = AppConfig(
    firebaseOptions: DefaultFirebaseOptions.currentPlatform,
    appEnvironment: AppEnvironment.staging,
  );

  runFitness(appConfig);
}
