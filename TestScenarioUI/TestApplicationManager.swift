//
//  TestApplicationManager.swift
//
//  Copyright (c) 2019 Ogarkov Anton
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import UIKit

/// Main class that assembles the test application and its data
final private class TestApplicationManager {
    fileprivate static let shared = TestApplicationManager()

    /// Root view controller that is being returned for integration with test application
    let testApplicationRootViewController: UIViewController

    /// Internal version of `testApplicationRootViewController`
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

/// Accessor for the main test application's root view controller.
/// Use it in your test application's AppDelegate e.g. as a root for your Window.
public func ScenarioTestingRootViewController() -> UIViewController {
    return TestApplicationManager.shared.testApplicationRootViewController
}

