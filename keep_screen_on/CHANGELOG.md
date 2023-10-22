## 3.0.0

- **Breaking change**. Changed arguments for turnOn methods from positional parameters to named parameters.(Changed ```turnOn(false)``` to ```turnOn(on: false)```.)
- **Breaking change**. Changed the minimum Android SDK version to 19.
- **Breaking change**. Changed the minimum iOS version to 11.0.
- **Breaking change**. Changed the minimum version of Flutter to 3.10.0.
- (Android only) Added the withAllowLockWhileScreenOn parameter to the turnOn and turnOff methods so that the FLAG_ALLOW_LOCK_WHILE_SCREEN_ON flag can be set at the same time on Android OS.
- (Android only) Added addAllowLockWhileScreenOn, clearAllowLockWhileScreenOn, isAllowLockWhileScreenOn methods to manipulate the FLAG_ALLOW_LOCK_WHILE_SCREEN_ON flag.
- (Android only) Adjusted so that it can be built with "Gradle 8".

## 2.1.0

- Migrating to Kotlin 1.7.20 and Gradle 7.3.1.

## 2.0.0

- Migrate to null safety.

## 1.0.0

* Initial release.
