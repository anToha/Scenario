import UIKit
import UI
import VCTDDTestingUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    let mainWindow = UIWindow(frame: UIScreen.main.bounds)
    self.window = mainWindow

    mainWindow.rootViewController = VCTDDTestingRootViewController()

    mainWindow.makeKeyAndVisible()

    return true
  }
}

