import UIKit

class TestApplicationManager {
    static let shared = TestApplicationManager()
    
    let testApplicationRootViewController: UIViewController
    
    private let internalTestApplicationRootViewController: TestApplicationRootViewController
    private let scenariosListController: UIViewController
    
    private var testScenariosRegistry: TestScenariosRegistry!
    
    init() {
        self.internalTestApplicationRootViewController = TestApplicationRootViewController()
        self.testApplicationRootViewController = self.internalTestApplicationRootViewController
        
        self.scenariosListController = UIViewController()
        
        self.testScenariosRegistry = TestScenariosRegistry(reportEventClosure: self.eventFiredReporterFunction)
    }
    
    func eventFiredReporterFunction(eventUniqueDescription: String) {
        self.internalTestApplicationRootViewController.firedEventLabelText = eventUniqueDescription
    }
}
