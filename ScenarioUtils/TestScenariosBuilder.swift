//
//  TestScenariosBuilder.swift
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

import Foundation
import Scenario

/// Get all subclasses of a desired class available in the current project.
fileprivate func getSubclassesOfClass(queriedClass: AnyClass) -> [AnyClass] {
    var count = UInt32(0)
    let classList = objc_copyClassList(&count)!

    var resultClasses = [AnyClass]()

    for i in 0 ..< Int(count) {
        if class_getSuperclass(classList[i]) == queriedClass {
            resultClasses.append(classList[i])
        }
    }
    return resultClasses
}

/// Initialize all instances of `TestScenario` subclasses.
///
/// - Parameter reportEventClosure: `(String) -> ()` closure that is used by `TestScenario` to report events
func buildTestScenarios(withReportEventClosure reportEventClosure: @escaping (String) -> ()) -> [TestScenario] {
    let testScenariosClasses = getSubclassesOfClass(queriedClass: TestScenario.self)

    return testScenariosClasses.map { (currentClass: AnyClass) -> TestScenario in
        let viewControllerTestScenarioClass = currentClass as! TestScenario.Type
        return viewControllerTestScenarioClass.init(reportEventClosure: reportEventClosure)
    }
}
