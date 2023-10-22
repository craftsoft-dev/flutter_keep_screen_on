## 3.0.0

- **Breaking change**. Changed arguments for turnOn methods from positional parameters to named parameters.(Changed ```turnOn(false)``` to ```turnOn(on: false)```.)
- **Breaking change**. Changed the minimum version of Flutter to 3.10.0.
- (Android only) Added the withAllowLockWhileScreenOn parameter to the turnOn and turnOff methods so that the FLAG_ALLOW_LOCK_WHILE_SCREEN_ON flag can be set at the same time on Android OS.
- (Android only) Added addAllowLockWhileScreenOn, clearAllowLockWhileScreenOn, isAllowLockWhileScreenOn methods to manipulate the FLAG_ALLOW_LOCK_WHILE_SCREEN_ON flag.

## 2.0.0+1

- Fixed the name mistake in the README.md.

## 2.0.0

- Migrate to null safety.

## 1.0.0

- Initial release.
