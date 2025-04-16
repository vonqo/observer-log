
import 'observer_log_platform_interface.dart';

class ObserverLog {
  Future<String?> getPlatformVersion() {
    return ObserverLogPlatform.instance.getPlatformVersion();
  }
}
