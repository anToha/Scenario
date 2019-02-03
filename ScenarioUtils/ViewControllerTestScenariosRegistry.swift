import Foundation
import Scenario

func getSubclassesOfClass(queriedClass: AnyClass) -> [AnyClass] {
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

class TestScenariosRegistry {
    private let testScenariosClasses: [AnyClass]

    private(set) lazy var testScenariosNames: [String] = {
        testScenariosClasses.map({String(describing: $0)})
    }()

    let testScenarios: [TestScenario]

    init(reportEventClosure:@escaping (String) -> (), testScenariosClassesToUse: [AnyClass]? = nil) {
        if let testScenariosClassesToUse = testScenariosClassesToUse {
            self.testScenariosClasses = testScenariosClassesToUse
        } else {
            self.testScenariosClasses = getSubclassesOfClass(queriedClass: TestScenario.self)
        }

        self.testScenarios = self.testScenariosClasses.lazy.map { (currentClass: AnyClass) -> TestScenario in
            let viewControllerTestScenarioClass = currentClass as! TestScenario.Type
            return viewControllerTestScenarioClass.init(reportEventClosure: reportEventClosure)
        }
    }
}

