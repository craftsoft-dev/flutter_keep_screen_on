# KeepScreenOn

このプラグインは、自動画面オフを無効にし、画面がオフにならないようにします。

## 始め方

`pubspec.yaml` ファイルに以下を追加します。

```yaml
dependencies:
  keep_screen_on: ^2.0.0
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
KeepScreenOn.turnOn(false);
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

## 注意

turnOnメソッドを引数無しまたはtrueを指定して呼び出すと、
内部動作としてAndroidはアクティビティのウィドウに対して android.view.WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON を設定します。  
iOSは UIApplication.shared.isIdleTimerDisabled を true に設定します。

このため、StatefulWidgetのdisposeメソッドなどで必ず
```dart
KeepScreenOn.turnOff();
```
を呼び出すようにする必要があります。
```turnOff```(または```turnOn(false)```)の呼び出しを忘れるとアプリ実行中は画面が自動消灯できなくなります。

Androidの場合、アクティビティが切り替わると自動画面オフは切り替わった先のアクティビティに従います。  
iOSの場合、バックグラウンドに移動すると自動画面オフは元に戻ります。