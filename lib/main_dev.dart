import 'package:fitness/run_fitness.dart';
import 'config/app_config.dart';
import 'firebase_options_dev.dart';

void main() {
  AppConfig appConfig = AppConfig(
    firebaseOptions: DefaultFirebaseOptions.currentPlatform,
    appEnvironment: AppEnvironment.development,
  );

  runFitness(appConfig);
}
