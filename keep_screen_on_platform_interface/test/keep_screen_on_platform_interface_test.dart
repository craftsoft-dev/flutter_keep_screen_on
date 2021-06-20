
import 'package:flutter_test/flutter_test.dart';
import 'package:keep_screen_on_platform_interface/keep_screen_on_platform_interface.dart';
import 'package:mockito/mockito.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('$KeepScreenOnPlatform', () {
    final defaultInstance = KeepScreenOnPlatform.instance;

    tearDown(() {
      KeepScreenOnPlatform.instance = defaultInstance;
    });

    test('$MethodChannelKeepScreenOn is the default instance', () {
      expect(KeepScreenOnPlatform.instance, isA<MethodChannelKeepScreenOn>());
    });

    test('Cannot be implemented with `implements`', () {
      expect(() {
        KeepScreenOnPlatform.instance = ImplementsKeepScreenOnPlatform();
      }, throwsNoSuchMethodError);
    });

    test('Can be extended', () {
      KeepScreenOnPlatform.instance = ExtendsKeepScreenOnPlatform();
    });

    test('Can be mocked with `implements`', () {
      final mock = MockKeepScreenOnPlatform();
      KeepScreenOnPlatform.instance = mock;
    });
  });
}

class ImplementsKeepScreenOnPlatform implements KeepScreenOnPlatform {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class MockKeepScreenOnPlatform extends Mock
  with MockPlatformInterfaceMixin
  implements KeepScreenOnPlatform {}

class ExtendsKeepScreenOnPlatform extends KeepScreenOnPlatform {}
