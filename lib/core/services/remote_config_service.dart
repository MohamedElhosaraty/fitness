import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  final _remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> init() async {
    await _remoteConfig.setDefaults({'exercises_updated': false});
    await _remoteConfig.fetchAndActivate();
  }

  bool get exercisesUpdated {
    return _remoteConfig.getBool('exercises_updated');
  }
}