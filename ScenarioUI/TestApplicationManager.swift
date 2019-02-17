import UIKit

final class TestApplicationManager {
    fileprivate static let shared = TestApplicationManager()

    let testApplicationRootViewController: UIViewController

    private let internalTestApplicationRootViewController: TestApplicationRootViewController
    private let scenariosListController: ScenariosListTableViewController

    private init() {
        self.scenariosListController = ScenariosListTableViewController()

        self.internalTestApplicationRootViewController = TestApplicationRootViewController(rootViewController: self.scenariosListController)
        self.testApplicationRootViewController = self.internalTestApplicationRootViewController
        self.internalTestApplicationRootViewController.closeScenarioButtonDidTouch = {
            self.internalTestApplicationRootViewController.popViewController(animated: false)
        }

        let testScenarios = buildTestScenarios(withReportEventClosure: self.eventFiredReporterFunction)

        var scenariosListItems = [ScenariosListTableViewController.Item]()
        for scenario in testScenarios {
            let scenarioName = String(describing: type(of: scenario))
            scenariosListItems.append((scenarioName, {
                let viewController = scenario.buildViewController()
                self.internalTestApplicationRootViewController.pushViewController(viewController, animated: false)
            }))
        }
        self.scenariosListController.scenariosList = scenariosListItems
    }

    private func eventFiredReporterFunction(eventUniqueDescription: String) {
        self.internalTestApplicationRootViewController.firedEventLabelText = eventUniqueDescription
    }
}

public func ScenarioTestingRootViewController() -> UIViewController {
    return TestApplicationManager.shared.testApplicationRootViewController
}

