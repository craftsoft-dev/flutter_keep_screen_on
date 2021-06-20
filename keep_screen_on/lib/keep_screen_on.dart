
import 'dart:async';

import 'package:keep_screen_on_platform_interface/keep_screen_on_platform_interface.dart';

///
/// The KeepScreen class controls the automatic screen off.
///
class KeepScreenOn {
  ///
  /// Returns true if automatic screen off is disabled.
  ///
  static Future<bool?> get isOn {
    return KeepScreenOnPlatform.instance.isOn;
  }

  ///
  /// Returns true if automatic screen off is enabled.
  ///
  static Future<bool?> get isOff {
    return KeepScreenOnPlatform.instance.isOff;
  }

  ///
  /// Disables automatic screen off.
  /// If you specify false for [on], the opposite operation is performed.
  ///
  static Future<bool> turnOn([bool on = true]) {
    return KeepScreenOnPlatform.instance.turnOn(on);
  }

  ///
  /// Enables automatic screen off.
  /// (Reset to default.)
  /// It is recommended to call it with the dispose method of StatefulWidget.
  ///
  static Future<bool> turnOff() {
    return KeepScreenOnPlatform.instance.turnOff();
  }
}
