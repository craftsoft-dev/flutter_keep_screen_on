part of keep_screen_on_platform_interface;

///
/// The KeepScreen class controls the automatic screen off.
///
class MethodChannelKeepScreenOn extends KeepScreenOnPlatform {
  
  static MethodChannelKeepScreenOn? _instance;

  final MethodChannel _methodChannel;

  factory MethodChannelKeepScreenOn() {
    if (_instance == null) {
      const methodChannel = MethodChannel('dev.craftsoft/keep_screen_on');
      _instance = MethodChannelKeepScreenOn.private(methodChannel);
    }

    return _instance!;
  }

  @visibleForTesting
  MethodChannelKeepScreenOn.private(this._methodChannel);

  ///
  /// Returns true if automatic screen off is disabled.
  ///
  @override
  Future<bool?> get isOn {
    return _methodChannel.invokeMethod<bool>('isOn');
  }

  ///
  /// Returns true if automatic screen off is enabled.
  ///
  @override
  Future<bool?> get isOff async {
    final result = await isOn;
    return (result is bool) ? !result : result;
  }

  /// Disables automatic screen off.
  /// If you specify false for [on], the opposite operation is performed.
  ///
  /// If [withAllowLockWhileScreenOn] is set to true,
  /// the FLAG_ALLOW_LOCK_WHILE_SCREEN_ON flag will also be assigned at
  /// the same time (Android only).
  @override
  Future<bool> turnOn({ bool on = true, bool withAllowLockWhileScreenOn = false }) {
    return _methodChannel.invokeMethod<bool>(
      'turnOn',
      {
        'on': on,
        'withAllowLockWhileScreenOn': withAllowLockWhileScreenOn,
      },
    ).then((result) => result ?? false);
  }

  /// Enables automatic screen off.
  /// (Reset to default.)
  /// It is recommended to call it with the dispose method of StatefulWidget.
  ///
  /// If [withAllowLockWhileScreenOn] is set to true,
  /// the FLAG_ALLOW_LOCK_WHILE_SCREEN_ON flag is also cleared at
  /// the same time (Android only).
  @override
  Future<bool> turnOff({ bool withAllowLockWhileScreenOn = false }) {
    return turnOn(
      on: false,
      withAllowLockWhileScreenOn: withAllowLockWhileScreenOn,
    );
  }

  /// Returns true if the FLAG_ALLOW_LOCK_WHILE_SCREEN_ON flag is assigned (Android only).
  Future<bool?> get isAllowLockWhileScreenOn {
    if (!Platform.isAndroid) {
      return Future.value();
    }

    return _methodChannel.invokeMethod<bool>('isAllowLockWhileScreenOn');
  }

  /// Assign the FLAG_ALLOW_LOCK_WHILE_SCREEN_ON flag to the window (Android only).
  /// If you specify false for [on], the opposite operation is performed.
  Future<bool> addAllowLockWhileScreenOn({ bool on = true }) {
    if (!Platform.isAndroid) {
      return Future.value(false);
    }

    return _methodChannel.invokeMethod<bool>(
      'addAllowLockWhileScreenOn',
      { 'on': on },
    ).then((result) => result ?? false);
  }

  /// Clears the FLAG_ALLOW_LOCK_WHILE_SCREEN_ON flag from the window (Android only).
  Future<bool> clearAllowLockWhileScreenOn() {
    return addAllowLockWhileScreenOn(on: false);
  }
}
