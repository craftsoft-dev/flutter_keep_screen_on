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

    methodChannel.setMockMethodCallHandler((call) async {
      log.add(call);

      switch (call.method) {
        case 'isOn':
          return null;

        case 'isOff':
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
