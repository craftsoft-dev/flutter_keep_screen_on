package dev.craftsoft.keepscreenon

import android.app.Activity
import android.util.Log
import android.view.WindowManager

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** KeepScreenOnPlugin */
public class KeepScreenOnPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  private var activity: Activity? = null

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, CHANNEL_NAME)
    channel.setMethodCallHandler(this);
  }

  override fun onMethodCall(call: MethodCall, result: Result) {

    when (call.method) {
      "isOn"   -> onMethodCallIsOn(call, result)
      "turnOn" -> onMethodCallTurnOn(call, result)

      "isAllowLockWhileScreenOn" -> onMethodCallIsAllowLockWhileScreenOn(call, result)
      "addAllowLockWhileScreenOn" -> onMethodCallAddAllowLockWhileScreenOn(call, result)

      else     -> {
        result.notImplemented();
      }
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  //
  // Implement ActivityAware
  //
  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivity() {
    activity = null
  }

  //
  // Implement a private method called from onMethodCall
  //
  private fun onMethodCallIsOn(@Suppress("UNUSED_PARAMETER") call: MethodCall, result: Result) {
    val window = activity?.window

    if (window == null) {
      result.error("not-found-activity", "Not found 'activity'.", null)
      return
    }

    val hasKeepScreenOn = (window.attributes.flags and WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON) != 0;
    result.success(hasKeepScreenOn);
  }

  private fun onMethodCallTurnOn(call: MethodCall, result: Result) {
    val window = activity?.window

    if (window == null) {
      result.error("not-found-activity", "Not found 'activity'.", null)
      return
    }

    val on = call.argument<Boolean>("on");
    val withAllowLockWhileScreenOn = call.argument<Boolean>("withAllowLockWhileScreenOn")

    val flag = WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON or
            if(withAllowLockWhileScreenOn == true)
              WindowManager.LayoutParams.FLAG_ALLOW_LOCK_WHILE_SCREEN_ON
            else
              0

    Log.d(TAG, "flag=$flag")

    if (on == true) {
      window.addFlags(flag)
    } else {
      window.clearFlags(flag);
    }

    result.success(true);
  }

  private fun onMethodCallIsAllowLockWhileScreenOn(call: MethodCall, result: Result) {
    val window = activity?.window

    if (window == null) {
      result.error("not-found-activity", "Not found 'activity'.", null)
      return
    }

    val hasAllowLockWhileScreenOn = (window.attributes.flags and WindowManager.LayoutParams.FLAG_ALLOW_LOCK_WHILE_SCREEN_ON) != 0;
    result.success(hasAllowLockWhileScreenOn);
  }

  private fun onMethodCallAddAllowLockWhileScreenOn(call: MethodCall, result: Result) {
    val window = activity?.window

    if (window == null) {
      result.error("not-found-activity", "Not found 'activity'.", null)
      return
    }

    val on = call.argument<Boolean>("on");
    val flag = WindowManager.LayoutParams.FLAG_ALLOW_LOCK_WHILE_SCREEN_ON

    if (on == true) {
      window.addFlags(flag)
    } else {
      window.clearFlags(flag);
    }

    result.success(true);
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  companion object {
    const val TAG = "KeepScreenOnPlugin";
    const val CHANNEL_NAME = "dev.craftsoft/keep_screen_on";

    @Suppress("DEPRECATION")
    @JvmStatic
    fun registerWith(registrar: io.flutter.plugin.common.PluginRegistry.Registrar) {
      val channel = MethodChannel(registrar.messenger(), CHANNEL_NAME)
      channel.setMethodCallHandler(KeepScreenOnPlugin())
    }
  }
}
