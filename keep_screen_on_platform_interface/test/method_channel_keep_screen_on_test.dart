import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'package:keep_screen_on_platform_interface/method_channel_keep_screen_on.dart';
import 'package:keep_screen_on_platform_interface/keep_screen_on_platform_interface.dart';

void main() {

  TestWidgetsFlutterBinding.ensureInitialized();


  group('$KeepScreenOnPlatform', () {
    test('$MethodChannelKeepScreenOn() is the default instance', () {
      expect(KeepScreenOnPlatform.instance, isInstanceOf<MethodChannelKeepScreenOn>());
    });

    test(
      'Cannot be implemented with `implements`',
      () {
        expect(
          () {
            KeepScreenOnPlatform.instance = ImplementsKeepScreenOnPlatform();
          },
          throwsA(isInstanceOf<AssertionError>())
        );
      }
    );

    test('Can be mocked with `implements`', () {
      final mock = KeepScreenOnPlatformMock();
      KeepScreenOnPlatform.instance = mock;
    });

    test('Can be extended', () {
      KeepScreenOnPlatform.instance = ExtendsKeepScreenOnPlatform();
    });
  });

  group('$MethodChannelKeepScreenOn', () {
    const MethodChannel channel = MethodChannel('dev.craftsoft/keep_screen_on');

    final List<MethodCall> log = <MethodCall>[];
    channel.setMockMethodCallHandler((call) async {
      log.add(call);
    });
  
    final keepScreenOn = MethodChannelKeepScreenOn();

    tearDown(() {
      log.clear();
    });

    test('turnOn', () async {
      await keepScreenOn.turnOn();
      expect(log, <Matcher>[isMethodCall('turnOn', arguments: <String, Object>{'turnOn': true})]);
    });

    test('turnOn false', () async {
      await keepScreenOn.turnOn(false);
      expect(log, <Matcher>[isMethodCall('turnOn', arguments: <String, Object>{'turnOn': false})]);
    });

    test('turnOff', () async {
      await keepScreenOn.turnOff();
      expect(log, <Matcher>[isMethodCall('turnOn', arguments: <String, Object>{'turnOn': false})]);
    });

    test('isOn', () async {
      final isOn = await keepScreenOn.isOn;
      expect(isOn, null);
      expect(log, <Matcher>[isMethodCall('isOn', arguments: null)]);
    });

    test('isOff', () async {
      final isOff = await keepScreenOn.isOff;
      expect(isOff, null);
      expect(log, <Matcher>[isMethodCall('isOn', arguments: null)]);
    });
  });
}


class KeepScreenOnPlatformMock extends Mock
  with MockPlatformInterfaceMixin
  implements KeepScreenOnPlatform {}

class ImplementsKeepScreenOnPlatform extends Mock
  implements KeepScreenOnPlatform {}

class ExtendsKeepScreenOnPlatform extends KeepScreenOnPlatform {}
