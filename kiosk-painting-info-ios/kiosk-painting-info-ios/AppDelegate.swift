import UIKit
import Flutter

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  var flutterEngine: FlutterEngine?
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    // Initialize Flutter engine
    flutterEngine = FlutterEngine(name: "my_engine")
    flutterEngine?.run()
    
    guard let flutterEngine = flutterEngine else { return true }
    // Create Flutter view controller with the engine
    let flutterViewController = FlutterViewController(
      engine: flutterEngine,
      nibName: nil,
      bundle: nil
    )
    
    // Set Flutter VC as root
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = flutterViewController
    window?.makeKeyAndVisible()
    
    return true
  }
}
