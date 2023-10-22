import Flutter
import UIKit

public class SwiftKeepScreenOnPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "dev.craftsoft/keep_screen_on", binaryMessenger: registrar.messenger())
        let instance = SwiftKeepScreenOnPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        switch call.method {
        case "isOn":
            handleIsOn(call: call, result: result)
            
        case "turnOn":
            handleTurnOn(call: call, result: result)
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func handleIsOn(call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(UIApplication.shared.isIdleTimerDisabled)
    }
    
    private func handleTurnOn(call: FlutterMethodCall, result: @escaping FlutterResult) {
        // Cannot process if call.arguments is not of type Dictionry
        guard let arguments = call.arguments as? Dictionary<String, Any?> else {
            result(FlutterError(code: "invalid-arguments", message: "The 'arguments' variable is not a Dictionary type.", details: nil))
            return
        }
        
        let on: Bool = arguments["on"] as? Bool ?? false
        
        UIApplication.shared.isIdleTimerDisabled = on
        
        result(true)
    }
}
