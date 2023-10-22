import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keep_screen_on_platform_interface/keep_screen_on_platform_interface.dart';

void main() {

  TestWidgetsFlutterBinding.ensureInitialized();

  late MethodChannel methodChannel;
  late MethodChannelKeepScreenOn keepScreenOn;

  final log = <MethodCall>[];

  setUp(() {
    methodChannel = const MethodChannel('dev.craftsoft/keep_screen_on');
    keepScreenOn = MethodChannelKeepScreenOn.private(methodChannel);

    TestDefaultBinaryMessengerBinding
        .instance
        .defaultBinaryMessenger
        .setMockMethodCallHandler(methodChannel, (message) {
          log.add(message);

          switch (message.method) {
            case 'isOn':
              return null;

            case 'isOff':
              return null;

            case 'isAllowLockWhileScreenOn':
              return null;

            default:
              return null;
          }
        });

    log.clear();
  });

  group('$KeepScreenOnPlatform', () {
    
    test('turnOn', () async {
      await keepScreenOn.turnOn();
      expect(log, <Matcher>[isMethodCall('turnOn', arguments: <String, Object>{'on': true, 'withAllowLockWhileScreenOn': false})]);
    });

    test('turnOn(on: false)', () async {
      await keepScreenOn.turnOn(on: false);
      expect(log, <Matcher>[isMethodCall('turnOn', arguments: <String, Object>{'on': false, 'withAllowLockWhileScreenOn': false})]);
    });

    test('turnOn(on: true, withAllowLockWhileScreenOn: true)', () async {
      await keepScreenOn.turnOn(on: true, withAllowLockWhileScreenOn: true);
      expect(log, <Matcher>[isMethodCall('turnOn', arguments: <String, Object>{'on': true, 'withAllowLockWhileScreenOn': true})]);
    });

    test('turnOff', () async {
      await keepScreenOn.turnOff();
      expect(log, <Matcher>[isMethodCall('turnOn', arguments: <String, Object>{'on': false, 'withAllowLockWhileScreenOn': false})]);
    });

    test('turnOff(withAllowLockWhileScreenOn: true)', () async {
      await keepScreenOn.turnOff(withAllowLockWhileScreenOn: true);
      expect(log, <Matcher>[isMethodCall('turnOn', arguments: <String, Object>{'on': false, 'withAllowLockWhileScreenOn': true})]);
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

    test('isAllowLockWhileScreenOn', () async {
      final isAllowLockWhileScreenOn = await keepScreenOn.isAllowLockWhileScreenOn;
      expect(isAllowLockWhileScreenOn, null);
    });

    test('addAllowLockWhileScreenOn', () async {
      final result = await keepScreenOn.addAllowLockWhileScreenOn();
      expect(result, false);
    });

    test('addAllowLockWhileScreenOn(on: false)', () async {
      final result = await keepScreenOn.addAllowLockWhileScreenOn(on: false);
      expect(result, false);
    });

    test('clearAllowLockWhileScreenOn', () async {
      final result = await keepScreenOn.clearAllowLockWhileScreenOn();
      expect(result, false);
    });
  });
}
