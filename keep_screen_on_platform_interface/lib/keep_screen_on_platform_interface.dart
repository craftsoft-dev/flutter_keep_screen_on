library keep_screen_on_platform_interface;

import 'dart:async';
import 'dart:io';

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

  /// Disables automatic screen off.
  /// If you specify false for [on], the opposite operation is performed.
  ///
  /// If [withAllowLockWhileScreenOn] is set to true,
  /// the FLAG_ALLOW_LOCK_WHILE_SCREEN_ON flag will also be assigned at
  /// the same time (Android only).
  Future<bool> turnOn({ bool on = true, bool withAllowLockWhileScreenOn = false }) {
    throw UnimplementedError('turnOn() has not been implemented.');
  }

  /// Enables automatic screen off.
  /// (Reset to default.)
  /// It is recommended to call it with the dispose method of StatefulWidget.
  ///
  /// If [withAllowLockWhileScreenOn] is set to true,
  /// the FLAG_ALLOW_LOCK_WHILE_SCREEN_ON flag is also cleared at
  /// the same time (Android only).
  Future<bool> turnOff({ bool withAllowLockWhileScreenOn = false }) {
    throw UnimplementedError('turnOff() has not been implemented.');
  }

  /// Returns true if the FLAG_ALLOW_LOCK_WHILE_SCREEN_ON flag is assigned (Android only).
  Future<bool?> get isAllowLockWhileScreenOn {
    throw UnimplementedError('isAllowLockWhileScreenOn has not been implemented.');
  }

  /// Assign the FLAG_ALLOW_LOCK_WHILE_SCREEN_ON flag to the window (Android only).
  /// If you specify false for [on], the opposite operation is performed.
  Future<bool> addAllowLockWhileScreenOn({ bool on = true }) {
    throw UnimplementedError('addAllowLockWhileScreenOn() has not been implemented.');
  }

  /// Clears the FLAG_ALLOW_LOCK_WHILE_SCREEN_ON flag from the window (Android only).
  Future<bool> clearAllowLockWhileScreenOn() {
    throw UnimplementedError('clearAllowLockWhileScreenOn() has not been implemented.');
  }
}
