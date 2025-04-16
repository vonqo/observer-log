import 'package:flutter_test/flutter_test.dart';
import 'package:observer_log/observer_log.dart';
import 'package:observer_log/observer_log_platform_interface.dart';
import 'package:observer_log/observer_log_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockObserverLogPlatform
    with MockPlatformInterfaceMixin
    implements ObserverLogPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ObserverLogPlatform initialPlatform = ObserverLogPlatform.instance;

  test('$MethodChannelObserverLog is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelObserverLog>());
  });

  test('getPlatformVersion', () async {
    ObserverLog observerLogPlugin = ObserverLog();
    MockObserverLogPlatform fakePlatform = MockObserverLogPlatform();
    ObserverLogPlatform.instance = fakePlatform;

    expect(await observerLogPlugin.getPlatformVersion(), '42');
  });
}
