import Flutter
import UIKit
import Network

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

  private let CHANNEL = "CONNECTIVITY_EVENT_CHANNEL"
  private var eventSink: FlutterEventSink?
  private var monitor: NWPathMonitor?
  private let queue = DispatchQueue.global(qos: .background)
  
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let connectivityChannel = FlutterEventChannel(name: CHANNEL, binaryMessenger: controller.binaryMessenger)
    
    connectivityChannel.setStreamHandler(self)
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

extension AppDelegate: FlutterStreamHandler {
  public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    eventSink = events
    monitor = NWPathMonitor()
    monitor?.pathUpdateHandler = { path in
      if path.status == .satisfied {
        events(true)
      } else {
        events(false)
      }
    }
    monitor?.start(queue: queue)
    
    return nil
  }
  
  public func onCancel(withArguments arguments: Any?) -> FlutterError? {
    monitor?.cancel()
    monitor = nil
    eventSink = nil
    
    return nil
  }
}