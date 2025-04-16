import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'observer_log_platform_interface.dart';

/// An implementation of [ObserverLogPlatform] that uses method channels.
class MethodChannelObserverLog extends ObserverLogPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('observer_log');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
