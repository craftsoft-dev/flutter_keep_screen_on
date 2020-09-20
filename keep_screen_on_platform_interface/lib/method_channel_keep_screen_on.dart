
import 'dart:async';

import 'package:flutter/services.dart';

import 'keep_screen_on_platform_interface.dart';

const MethodChannel _channel = const MethodChannel('dev.craftsoft/keep_screen_on');

///
/// The KeepScreen class controls the automatic screen off.
///
class MethodChannelKeepScreenOn extends KeepScreenOnPlatform {
  ///
  /// Returns true if automatic screen off is disabled.
  ///
  @override
  Future<bool> get isOn {
    return _channel.invokeMethod<bool>('isOn');
  }

  ///
  /// Returns true if automatic screen off is enabled.
  ///
  @override
  Future<bool> get isOff async {
    return isOn.then((value) {
      if (value is bool) {
        return !value;
      }

      return value;
    });
  }

  ///
  /// Disables automatic screen off.
  /// If you specify false for [on], the opposite operation is performed.
  ///
  @override
  Future<bool> turnOn([bool on = true]) {
    return _channel.invokeMethod<bool>('turnOn', {'turnOn': on});
  }

  ///
  /// Enables automatic screen off.
  /// (Reset to default.)
  /// It is recommended to call it with the dispose method of StatefulWidget.
  ///
  @override
  Future<bool> turnOff() {
    return turnOn(false);
  }
}
