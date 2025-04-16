import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'observer_log_method_channel.dart';

abstract class ObserverLogPlatform extends PlatformInterface {
  /// Constructs a ObserverLogPlatform.
  ObserverLogPlatform() : super(token: _token);

  static final Object _token = Object();

  static ObserverLogPlatform _instance = MethodChannelObserverLog();

  /// The default instance of [ObserverLogPlatform] to use.
  ///
  /// Defaults to [MethodChannelObserverLog].
  static ObserverLogPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ObserverLogPlatform] when
  /// they register themselves.
  static set instance(ObserverLogPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
