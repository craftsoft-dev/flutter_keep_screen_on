
import 'package:flutter_test/flutter_test.dart';
import 'package:keep_screen_on/keep_screen_on.dart';
import 'package:mockito/mockito.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:keep_screen_on_platform_interface/keep_screen_on_platform_interface.dart';

void main() {
  final mock = MockKeepScreenOn();
  KeepScreenOnPlatform.instance = mock;

  TestWidgetsFlutterBinding.ensureInitialized();

  test('isOn', () async {
    expect(await KeepScreenOn.isOn, null);
  });

  test('isOff', () async {
    expect(await KeepScreenOn.isOff, null);
  });
  
  test('turnOn', () async {
    expect(await KeepScreenOn.turnOn(), null);
  });
  
  test('turnOn(false)', () async {
    expect(await KeepScreenOn.turnOn(false), null);
  });
  
  test('turnOff', () async {
    expect(await KeepScreenOn.turnOff(), null);
  });
}

class MockKeepScreenOn extends Mock
  with MockPlatformInterfaceMixin
  implements KeepScreenOnPlatform {}
