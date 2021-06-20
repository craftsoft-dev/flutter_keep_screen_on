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

  ///
  /// Disables automatic screen off.
  /// If you specify false for [on], the opposite operation is performed.
  ///
  @override
  Future<bool> turnOn([bool on = true]) async {
    final result = await _methodChannel.invokeMethod<bool>('turnOn', {'turnOn': on});
    return result ?? false;
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
