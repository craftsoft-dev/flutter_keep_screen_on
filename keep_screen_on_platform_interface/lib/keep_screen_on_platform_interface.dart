library keep_screen_on_platform_interface;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

part 'src/method_channel_keep_screen_on.dart';

///
/// The KeepScreen class controls the automatic screen off.
///
abstract class KeepScreenOnPlatform extends PlatformInterface {
  
  KeepScreenOnPlatform() : super(token: _token);

  static final Object _token = Object();

  static KeepScreenOnPlatform _instance = MethodChannelKeepScreenOn();

  static KeepScreenOnPlatform get instance => _instance;

  static set instance(KeepScreenOnPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  ///
  /// Returns true if automatic screen off is disabled.
  ///
  Future<bool?> get isOn {
    throw UnimplementedError('isOn has not been implemented.');
  }

  ///
  /// Returns true if automatic screen off is enabled.
  ///
  Future<bool?> get isOff {
    throw UnimplementedError('isOff has not been implemented.');
  }

  ///
  /// Disables automatic screen off.
  /// If you specify false for [on], the opposite operation is performed.
  ///
  Future<bool> turnOn([bool on = true]) {
    throw UnimplementedError('turnOn() has not been implemented.');
  }

  ///
  /// Enables automatic screen off.
  /// (Reset to default.)
  /// It is recommended to call it with the dispose method of StatefulWidget.
  ///
  Future<bool> turnOff() {
    throw UnimplementedError('turnOff() has not been implemented.');
  }
}
