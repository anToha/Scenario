import UIKit
import SampleAppUI
import ScenarioUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    let mainWindow = UIWindow(frame: UIScreen.main.bounds)
    self.window = mainWindow

    mainWindow.rootViewController = ScenarioTestingRootViewController()

    mainWindow.makeKeyAndVisible()

    return true
  }
}

