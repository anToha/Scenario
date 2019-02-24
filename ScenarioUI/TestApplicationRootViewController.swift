//
//  TestApplicationRootViewController.swift
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

/// Root view controller for the test application.
class TestApplicationRootViewController: UINavigationController {
    var firedEventLabelText: String = "" {
        didSet {
            self.eventsReportingLabel?.text = firedEventLabelText
        }
    }

    /// Fired when the secret button is touched by the tests.
    var closeScenarioButtonDidTouch: () -> () = {}

    private var eventsReportingLabel: UILabel?
    private var closeScenarioButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.isNavigationBarHidden = true

        let screenBounds = UIScreen.main.bounds

        let closeScenarioButton = UIButton(type: .custom)
        closeScenarioButton.frame = CGRect(x: 0, y: screenBounds.maxY - 1, width: 1, height: 1)
        closeScenarioButton.accessibilityIdentifier = "closeScenarioButton"
        closeScenarioButton.addTarget(self, action: #selector(closeScenarioButtonDidTouchAction), for: .touchUpInside)
        self.view.addSubview(closeScenarioButton)

        let eventsReportingLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        eventsReportingLabel.accessibilityIdentifier = "eventsReportingLabel"
        self.view.addSubview(eventsReportingLabel)
        self.view.sendSubview(toBack: eventsReportingLabel)

        self.eventsReportingLabel = eventsReportingLabel
    }

    @objc
    private func closeScenarioButtonDidTouchAction() {
        self.closeScenarioButtonDidTouch()
    }
}

