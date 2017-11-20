import UIKit

class TestApplicationManager {
  static let shared = TestApplicationManager()

  let testApplicationRootViewController: UIViewController

  private let internalTestApplicationRootViewController: TestApplicationRootViewController
  private let scenariosListController: ScenariosListTableViewController

  private var testScenariosRegistry: TestScenariosRegistry!

  init() {
    self.scenariosListController = ScenariosListTableViewController()

    self.internalTestApplicationRootViewController = TestApplicationRootViewController(rootViewController: self.scenariosListController)
    self.testApplicationRootViewController = self.internalTestApplicationRootViewController
    self.internalTestApplicationRootViewController.closeScenarioButtonDidTouch = {
      self.internalTestApplicationRootViewController.popViewController(animated: false)
    }

    self.testScenariosRegistry = TestScenariosRegistry(reportEventClosure: self.eventFiredReporterFunction)

    var renderableScenarios = [ScenariosListTableViewController.Scenario]()
    for (scenarioIndex, scenarioName) in self.testScenariosRegistry.testScenariosNames.enumerated() {
      renderableScenarios.append((scenarioName, {
        let selectedScenario = self.testScenariosRegistry.testScenarios[scenarioIndex]
        self.internalTestApplicationRootViewController.pushViewController(selectedScenario.buildViewController(), animated: false)
      }))
    }
    self.scenariosListController.scenariosList = renderableScenarios
  }

  func eventFiredReporterFunction(eventUniqueDescription: String) {
    self.internalTestApplicationRootViewController.firedEventLabelText = eventUniqueDescription
  }
}
