import Flutter
import UIKit
import flutter_local_notification
@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    FlutterLocalNotificationPlugin.setPluginRegistrantCallback{
    (registry) in GeneratedPluginRegistrant.register(with: registry)
    }
    GeneratedPluginRegistrant.register(with: self)
    if #available(iOS 10.0,*){
    UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenter
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}