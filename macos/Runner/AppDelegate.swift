import Cocoa
import FlutterMacOS

@main
class AppDelegate: FlutterAppDelegate {

  override func applicationDidFinishLaunching(_ notification: Notification) {
    let window = NSApp.windows.first
    window?.aspectRatio = NSSize(width: 16, height: 9)
    super.applicationDidFinishLaunching(notification)
  }
  
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }

  override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }
}
