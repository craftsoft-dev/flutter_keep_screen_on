# KeepScreenOn

このプラグインは、自動画面オフを無効にし、画面がオフにならないようにします。

## 始め方

`pubspec.yaml` ファイルに以下を追加します。

```yaml
dependencies:
  keep_screen_on: ^4.0.0
```

## 使い方

KeepScreenOn をインポートします。

```dart
import 'package:keep_screen_on/keep_screen_on.dart';
```

画面を消灯しないようにするには、KeepScreenOnクラスのturnOnメソッドを呼び出します。 

```dart
// Keep the screen on.
KeepScreenOn.turnOn();
```

画面を消灯するように元に戻すには、KeepScreenOnクラスのturnOffメソッドを呼び出します。  
または、turnOnメソッドにfalseを渡すことで同じ動作をします。

```dart
// Reset
KeepScreenOn.turnOff();

// or...
KeepScreenOn.turnOn(on: false);
```

現在、画面が消灯しないようになっているかはisOnプロパティまたはisOffプロパティで確認できます。  
isOnおよびisOffはFuture<bool?>を返すため"await"を利用するか"then"メソッドで値を受け取る必要があります。

```dart
Future<bool?> getScreenKeepOn() async {
  return await KeepScreenOn.isOn; 
}

Future<bool?> getScreenKeepOff() async {
  return await KeepScreenOn.isOff;
}
```

### Androidのみの機能

Androidでは以下の機能を利用できます。  
Android以外のOSでは実行しても何もおきません。

turnOn および turnOff メソッドに withAllowLockWhileScreenOn 引数を指定できます。  
```withAllowLockWhileScreenOn: true``` とした場合[FLAG_ALLOW_LOCK_WHILE_SCREEN_ON](https://developer.android.com/reference/android/view/WindowManager.LayoutParams#FLAG_ALLOW_LOCK_WHILE_SCREEN_ON)を一緒に指定します。

```dart
KeepScreenOn.turnOn(withAllowLockWhileScreenOn: true);

KeepScreenOn.turnOff(withAllowLockWhileScreenOn: true);
```

[FLAG_ALLOW_LOCK_WHILE_SCREEN_ON](https://developer.android.com/reference/android/view/WindowManager.LayoutParams#FLAG_ALLOW_LOCK_WHILE_SCREEN_ON)のみを切り替える場合、以下のメソッドを呼び出す事で切り替えることができます。

```dart
KeepScreenOn.addAllowLockWhileScreenOn();

KeepScreenOn.clearAllowLockWhileScreenOn();
```

[FLAG_ALLOW_LOCK_WHILE_SCREEN_ON](https://developer.android.com/reference/android/view/WindowManager.LayoutParams#FLAG_ALLOW_LOCK_WHILE_SCREEN_ON)の割り当て状況は isAllowLockWhileScreenOn プロパティから確認できます。

```dart
KeepScreenOn.isAllowLockWhileScreenOn
```

それぞれの呼び出しはAndroid OS以外では以下の値を返します。

| Method/Property             | 戻り値  |
|-----------------------------|---------|
| addAllowLockWhileScreenOn   | false   |
| clearAllowLockWhileScreenOn | false   |
| isAllowLockWhileScreenOn    | null    |


## 注意

turnOnメソッドを引数無しまたは```on: true```を指定して呼び出すと、
内部動作としてAndroidはアクティビティのウィドウに対して android.view.WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON を設定します。  
iOSは UIApplication.shared.isIdleTimerDisabled を true に設定します。

このため、StatefulWidgetのdisposeメソッドなどで必ず
```dart
KeepScreenOn.turnOff();
```
を呼び出すようにする必要があります。
```turnOff```(または```turnOn(on: false)```)の呼び出しを忘れるとアプリ実行中は画面が自動消灯できなくなります。

Androidの場合、アクティビティが切り替わると自動画面オフは切り替わった先のアクティビティに従います。  
iOSの場合、バックグラウンドに移動すると自動画面オフは元に戻ります。
