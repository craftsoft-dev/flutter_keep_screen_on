
import 'package:flutter_test/flutter_test.dart';
import 'package:keep_screen_on/keep_screen_on.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:keep_screen_on_platform_interface/keep_screen_on_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'keep_screen_on_test.mocks.dart';

@GenerateMocks([KeepScreenOnPlatformMockMixin])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final mock = MockKeepScreenOnPlatformMockMixin();
  KeepScreenOnPlatform.instance = mock;

  tearDown(resetMockitoState);

  test('isOn', () async {
    when(KeepScreenOn.isOn).thenAnswer((realInvocation) => Future.value(true));
    expect(await KeepScreenOn.isOn, true);
  });

  test('isOff', () async {
    when(KeepScreenOn.isOff).thenAnswer((realInvocation) => Future.value(true));
    expect(await KeepScreenOn.isOff, true);
  });

  test('turnOn', () async {
    when(KeepScreenOn.turnOn()).thenAnswer((value) => Future.value(true));
    expect(await KeepScreenOn.turnOn(), true);
  });

  test('turnOn(false)', () async {
    when(KeepScreenOn.turnOn(false)).thenAnswer((value) => Future.value(true));
    expect(await KeepScreenOn.turnOn(false), true);
  });

  test('turnOff', () async {
    when(KeepScreenOn.turnOff()).thenAnswer((value) => Future.value(true));
    expect(await KeepScreenOn.turnOff(), true);
  });
}

class KeepScreenOnPlatformMockMixin extends KeepScreenOnPlatform
  with MockPlatformInterfaceMixin {}
