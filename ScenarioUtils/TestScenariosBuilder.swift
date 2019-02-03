import Foundation
import Scenario

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

func buildTestScenarios(withReportEventClosure reportEventClosure: @escaping (String) -> ()) -> [TestScenario] {
    let testScenariosClasses = getSubclassesOfClass(queriedClass: TestScenario.self)

    return testScenariosClasses.map { (currentClass: AnyClass) -> TestScenario in
        let viewControllerTestScenarioClass = currentClass as! TestScenario.Type
        return viewControllerTestScenarioClass.init(reportEventClosure: reportEventClosure)
    }
}
