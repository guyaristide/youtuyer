import Flutter
import UIKit

public class SwiftYoutuyerPlugin: NSObject, FlutterPlugin {
    

  /*public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "youtuyer", binaryMessenger: registrar.messenger())
    let instance = SwiftYoutuyerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }*/
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        registrar.register(YoutuyerFactory(_registrar: registrar),
                           withId: "youtuyer")
    }
}
