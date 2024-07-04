import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:fleet_tracker/Constants/Enum/remote_config_keys_enum.dart';

class RemoteConfigService {
  FirebaseRemoteConfig get remoteConfig => FirebaseRemoteConfig.instance;

  /// RemoteConfigの初期化
  Future<void> initalize() async {
    await setConfigSettings();
    await fetchAndActivate();
  }

  Future<void> setConfigSettings() async {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: Duration.zero,
    ));
  }

  Future<void> fetchAndActivate() async {
    await remoteConfig.fetchAndActivate();
  }

  int getInt(RemoteConfigKeys key) {
    return remoteConfig.getInt(key.name);
  }

  String getString(RemoteConfigKeys key) {
    return remoteConfig.getString(key.name);
  }

  bool getBool(RemoteConfigKeys key) {
    return remoteConfig.getBool(key.name);
  }

  double getDouble(RemoteConfigKeys key) {
    return remoteConfig.getDouble(key.name);
  }
}
