# KeepScreenOn

This plugin disables automatic screen off and prevents the screen from turning off.

## Getting Started

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  keep_screen_on: ^4.0.0
```

## Usage

Import KeepScreenOn.

```dart
import 'package:keep_screen_on/keep_screen_on.dart';
```

To keep the screen from turning off, call the turnOn method of the KeepScreenOn class.

```dart
// Keep the screen on.
KeepScreenOn.turnOn();
```

Calling the turnOff method of the KeepScreenOn class will restore the screen to turn off automatically.  
Alternatively, you can do the same by specifying false as the argument to the turnOn method.

```dart
// Reset
KeepScreenOn.turnOff();

// or...
KeepScreenOn.turnOn(on: false);
```

You can check if the screen is not turned off by checking the isOn property or isOff property.  
Since isOn and isOff return Future <bool?>, you need to use "await" or receive the value with the "then" method.

```dart
Future<bool?> getScreenKeepOn() async {
  return await KeepScreenOn.isOn; 
}

Future<bool?> getScreenKeepOff() async {
  return await KeepScreenOn.isOff;
}
```

### Android only.

The following functions are available on Android.
Nothing happens even if you run it on an OS other than Android.

You can specify the withAllowLockWhileScreenOn argument to the turnOn and turnOff methods.  
When ```withAllowLockWhileScreenOn: true``` is specified, [FLAG_ALLOW_LOCK_WHILE_SCREEN_ON](https://developer.android.com/reference/android/view/WindowManager.LayoutParams#FLAG_ALLOW_LOCK_WHILE_SCREEN_ON) is also specified in addition to [FLAG_KEEP_SCREEN_ON](https://developer.android.com/reference/android/view/WindowManager.LayoutParams#FLAG_KEEP_SCREEN_ON).

```dart
KeepScreenOn.turnOn(withAllowLockWhileScreenOn: true);

KeepScreenOn.turnOff(withAllowLockWhileScreenOn: true);
```

If you want to switch only [FLAG_ALLOW_LOCK_WHILE_SCREEN_ON](https://developer.android.com/reference/android/view/WindowManager.LayoutParams#FLAG_ALLOW_LOCK_WHILE_SCREEN_ON), you can do so by calling the method below.

```dart
KeepScreenOn.addAllowLockWhileScreenOn();

KeepScreenOn.clearAllowLockWhileScreenOn();
```

You can check the assignment status of [FLAG_ALLOW_LOCK_WHILE_SCREEN_ON](https://developer.android.com/reference/android/view/WindowManager.LayoutParams#FLAG_ALLOW_LOCK_WHILE_SCREEN_ON) from the isAllowLockWhileScreenOn property.

```dart
KeepScreenOn.isAllowLockWhileScreenOn
```

Each call returns the following values on non-Android OS:

| Method/Property             | Returns |
|-----------------------------|---------|
| addAllowLockWhileScreenOn   | false   |
| clearAllowLockWhileScreenOn | false   |
| isAllowLockWhileScreenOn    | null    |




## Attention

When you call the turnOn method with no arguments or with ```on: true```,  
Android sets ```android.view.WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON``` for the activity window as an internal action.  
iOS sets ```UIApplication.shared.isIdleTimerDisabled``` to true.

For this reason, be sure to use the dispose method of StatefulWidget etc.
```dart
KeepScreenOn.turnOff();
```
Should be called.
If you forget to call ```turnOff``` (or ``` turnOn(on: false) ```), the screen will not turn off automatically while the app is running.

For Android, when the activity is switched, the automatic screen off will follow the activity to which it was switched.  
For iOS, automatic screen off is restored when you move to the background.
