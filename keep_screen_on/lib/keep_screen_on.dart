
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

  /// Disables automatic screen off.
  /// If you specify false for [on], the opposite operation is performed.
  ///
  /// If [withAllowLockWhileScreenOn] is set to true,
  /// the FLAG_ALLOW_LOCK_WHILE_SCREEN_ON flag will also be assigned at
  /// the same time (Android only).
  static Future<bool> turnOn({ bool on = true, bool withAllowLockWhileScreenOn = false }) {
    return KeepScreenOnPlatform.instance.turnOn(
      on: on,
      withAllowLockWhileScreenOn: withAllowLockWhileScreenOn,
    );
  }

  /// Enables automatic screen off.
  /// (Reset to default.)
  /// It is recommended to call it with the dispose method of StatefulWidget.
  ///
  /// If [withAllowLockWhileScreenOn] is set to true,
  /// the FLAG_ALLOW_LOCK_WHILE_SCREEN_ON flag is also cleared at
  /// the same time (Android only).
  static Future<bool> turnOff({ bool withAllowLockWhileScreenOn = false }) {
    return KeepScreenOnPlatform.instance.turnOff(
      withAllowLockWhileScreenOn: withAllowLockWhileScreenOn,
    );
  }

  /// Returns true if the FLAG_ALLOW_LOCK_WHILE_SCREEN_ON flag is assigned (Android only).
  static Future<bool?> get isAllowLockWhileScreenOn {
    return KeepScreenOnPlatform.instance.isAllowLockWhileScreenOn;
  }

  /// Assign the FLAG_ALLOW_LOCK_WHILE_SCREEN_ON flag to the window (Android only).
  /// If you specify false for [on], the opposite operation is performed.
  static Future<bool> addAllowLockWhileScreenOn({bool on = true}) {
    return KeepScreenOnPlatform.instance.addAllowLockWhileScreenOn(on: on);
  }

  /// Clears the FLAG_ALLOW_LOCK_WHILE_SCREEN_ON flag from the window (Android only).
  static Future<bool> clearAllowLockWhileScreenOn() {
    return KeepScreenOnPlatform.instance.clearAllowLockWhileScreenOn();
  }
}
