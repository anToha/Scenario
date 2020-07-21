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
import TestScenario

/// Configuration for the test application. It contains everything that is necessary for the test app to work properly
public struct TestApplicationManagerConfig {
    /// all scenarios that should be accessible through the table view of ScenarioTestingRootViewController
    let scenariosClasses: [TestScenario.Type]

    public init(scenariosClasses: [TestScenario.Type]) {
        self.scenariosClasses = scenariosClasses
    }
}

/// Main class that assembles the test application and its data
final private class TestApplicationManager {
    fileprivate static let shared = TestApplicationManager()

    /// Root view controller that is being returned for integration with test application
    var testApplicationRootViewController: UIViewController?

    /// Internal version of `testApplicationRootViewController`
    private var internalTestApplicationRootViewController: TestApplicationRootViewController?

    private func eventFiredReporterFunction(eventUniqueDescription: String) {
        self.internalTestApplicationRootViewController?.firedEventLabelText = eventUniqueDescription
    }

    func configure(withConfig config: TestApplicationManagerConfig) {
        let scenariosListController = ScenariosListTableViewController()

        let internalTestApplicationRootViewController = TestApplicationRootViewController(rootViewController: scenariosListController)
        self.testApplicationRootViewController = internalTestApplicationRootViewController
        internalTestApplicationRootViewController.closeScenarioButtonDidTouch = { [weak internalTestApplicationRootViewController] in
            internalTestApplicationRootViewController?.popViewController(animated: false)
        }

        let testScenarios = build(testScenarios: config.scenariosClasses, withReportEventClosure: self.eventFiredReporterFunction)

        var scenariosListItems = [ScenariosListTableViewController.Item]()
        for scenario in testScenarios {
            let scenarioName = String(describing: type(of: scenario))
            scenariosListItems.append((scenarioName, { [weak internalTestApplicationRootViewController] in
                let viewController = scenario.buildViewController()
                internalTestApplicationRootViewController?.pushViewController(viewController, animated: false)
            }))
        }
        scenariosListController.scenariosList = scenariosListItems

        self.internalTestApplicationRootViewController = internalTestApplicationRootViewController
        self.testApplicationRootViewController = internalTestApplicationRootViewController
    }
}

/// Accessor for the main test application's root view controller.
/// Use it in your test application's AppDelegate e.g. as a root for your Window.
public func ScenarioTestingRootViewController() -> UIViewController {
    guard let rootVC = TestApplicationManager.shared.testApplicationRootViewController else {
        preconditionFailure("ScenarioTestingRootViewController is not configured. Please call ")
    }
    return rootVC
}

/// Configurator for the TestScenario test application. It will create the necessary UI for your test app
/// - parameter withConfig: configuration containing the reqiuired info for the application to work properly
public func ConfigureTestApplication(withConfig config: TestApplicationManagerConfig) {
    TestApplicationManager.shared.configure(withConfig: config)
}

