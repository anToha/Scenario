import Foundation
import UIKit.UIViewController

class ViewControllerTestScenario {
    let reportEventClosure: (_ uniqueEventDescription: String)->()
    
    required init(reportEventClosure: @escaping (_ uniqueEventDescription: String)->()) {
        self.reportEventClosure = reportEventClosure
    }
    
    func buildViewController() -> UIViewController {
        preconditionFailure("Implement this method in subclass.")
    }
}

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
    
    let testScenarios: [ViewControllerTestScenario]
    
    init(reportEventClosure:@escaping (String) -> (), testScenariosClassesToUse: [AnyClass]? = nil) {
        if let testScenariosClassesToUse = testScenariosClassesToUse {
            self.testScenariosClasses = testScenariosClassesToUse
        } else {
            self.testScenariosClasses = getSubclassesOfClass(queriedClass: ViewControllerTestScenario.self)
        }
        
        self.testScenarios = self.testScenariosClasses.lazy.map { (currentClass: AnyClass) -> ViewControllerTestScenario in
            let viewControllerTestScenarioClass = currentClass as! ViewControllerTestScenario.Type
            return viewControllerTestScenarioClass.init(reportEventClosure: reportEventClosure)
        }
    }
}










class ViewController1: UIViewController {
    typealias Props = (a: String, b: Int, buttonTouch: () -> ())
    var props: Props = ("", 0, {})
}


class TestScenarioA: ViewControllerTestScenario {
    
    override func buildViewController() -> UIViewController {
        let vc = ViewController1()
        vc.props = self.props()
        return vc
    }
    
    func props() -> ViewController1.Props {
        return ("", 0, {
            self.reportEventClosure(#file + #function)
        })
    }
    
}
