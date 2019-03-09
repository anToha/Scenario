//
//  ExampleUITests.swift
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

import XCTest
import TestScenarioUtils

class ExampleUITests: XCTestCase {

    override func setUp() {
        super.setUp()

        continueAfterFailure = false
        XCUIApplication().launch()

    }

    func test01() {
        let validationScenarioA = ActivateScenario(scenario: TestScenarioA.self)

        let app = XCUIApplication()
        app/*@START_MENU_TOKEN@*/.buttons["testButton"]/*[[".buttons[\"Test Button\"]",".buttons[\"testButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        ValidateScenarioEventIsFired(eventToValidate: validationScenarioA.props().buttonPressed())

        XCTAssert(app/*@START_MENU_TOKEN@*/.staticTexts["titleLabel"]/*[[".staticTexts[\"Hello\"]",".staticTexts[\"titleLabel\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.label == validationScenarioA.props().title)

        DeactivateScenario()

        let validationScenarioB = ActivateScenario(scenario: TestScenarioB.self)

        app/*@START_MENU_TOKEN@*/.buttons["testButton"]/*[[".buttons[\"Test Button\"]",".buttons[\"testButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        ValidateScenarioEventIsFired(eventToValidate: validationScenarioB.props().buttonPressed())

        XCTAssert(app/*@START_MENU_TOKEN@*/.staticTexts["titleLabel"]/*[[".staticTexts[\"Hello\"]",".staticTexts[\"titleLabel\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.label == validationScenarioB.props().title)

        DeactivateScenario()
    }
}


