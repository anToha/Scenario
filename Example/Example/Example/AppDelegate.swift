import UIKit
import ExampleUI
import ScenarioUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    let mainWindow = UIWindow(frame: UIScreen.main.bounds)
    self.window = mainWindow

    mainWindow.rootViewController = ScenarioTestingRootViewController()

    mainWindow.makeKeyAndVisible()

    return true
  }
}

