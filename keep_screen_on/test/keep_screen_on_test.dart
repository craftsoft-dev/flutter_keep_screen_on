
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

  test('turnOn(on: false)', () async {
    when(KeepScreenOn.turnOn(on: false)).thenAnswer((value) => Future.value(true));
    expect(await KeepScreenOn.turnOn(on: false), true);
  });

  test('turnOn(on: true, withAllowLockWhileScreenOn: true)', () async {
    when(KeepScreenOn.turnOn(on: true, withAllowLockWhileScreenOn: true))
        .thenAnswer((value) => Future.value(true));
    expect(await KeepScreenOn.turnOn(on: false), true);
  });

  test('turnOff', () async {
    when(KeepScreenOn.turnOff()).thenAnswer((value) => Future.value(true));
    expect(await KeepScreenOn.turnOff(), true);
  });

  test('turnOff(withAllowLockWhileScreenOn: true)', () async {
    when(KeepScreenOn.turnOff(withAllowLockWhileScreenOn: true))
        .thenAnswer((value) => Future.value(true));
    expect(await KeepScreenOn.turnOff(), true);
  });

  test('isAllowLockWhileScreenOn', () async {
    when(KeepScreenOn.isAllowLockWhileScreenOn)
        .thenAnswer((realInvocation) => Future.value(true));
    expect(await KeepScreenOn.isAllowLockWhileScreenOn, true);
  });

  test('addAllowLockWhileScreenOn', () async {
    when(KeepScreenOn.addAllowLockWhileScreenOn())
        .thenAnswer((value) => Future.value(true));
    expect(await KeepScreenOn.addAllowLockWhileScreenOn(), true);
  });

  test('addAllowLockWhileScreenOn(on: false)', () async {
    when(KeepScreenOn.addAllowLockWhileScreenOn(on: false))
        .thenAnswer((value) => Future.value(true));
    expect(await KeepScreenOn.addAllowLockWhileScreenOn(on :false), true);
  });

  test('clearAllowLockWhileScreenOn', () async {
    when(KeepScreenOn.clearAllowLockWhileScreenOn())
        .thenAnswer((value) => Future.value(true));
    expect(await KeepScreenOn.clearAllowLockWhileScreenOn(), true);
  });
}

class KeepScreenOnPlatformMockMixin extends KeepScreenOnPlatform
  with MockPlatformInterfaceMixin {}
