import XCTest

class ValidationTestScenariosManager {
    static let shared = ValidationTestScenariosManager()

    private(set) var reportedEventDescription = ""
    private var testScenariosRegistry: TestScenariosRegistry!

    init() {
        self.testScenariosRegistry = TestScenariosRegistry(reportEventClosure: self.eventFiredReporterFunction)
    }
    
    func eventFiredReporterFunction(eventUniqueDescription: String) {
        self.reportedEventDescription = eventUniqueDescription
    }
    
    private func scenarioIndex(scenario: ViewControllerTestScenario.Type) -> Int? {
        return testScenariosRegistry.testScenariosNames.index(of: String(describing: scenario))
    }
    
    private func getValidationScenarioInstance(scenarioClass: ViewControllerTestScenario.Type) -> ViewControllerTestScenario? {
        
        // TODO: avoid using index
        guard let scenarioIndex = self.scenarioIndex(scenario: scenarioClass) else {
            return nil
        }
        return self.testScenariosRegistry.testScenarios[scenarioIndex]
    }
    
    func validateEventIsFired(eventToValidate: () -> ()) {
        eventToValidate()
        XCTAssert(XCUIApplication().staticTexts["eventsReportingLabel"].label == self.reportedEventDescription)
    }

    func activateScenario(scenario: ViewControllerTestScenario.Type) -> ViewControllerTestScenario? {
        guard let scenarioInstance = self.getValidationScenarioInstance(scenarioClass: scenario) else {
            return nil
        }
        XCUIApplication().tables.staticTexts[String(describing: scenario)].tap()
        return scenarioInstance
    }
}


// helper functions
func VCTDDValidateEventIsFired(eventToValidate: @autoclosure () -> () -> ()) {
    ValidationTestScenariosManager.shared.validateEventIsFired(eventToValidate: eventToValidate())
}

func VCTDDActivateScenario(scenario: ViewControllerTestScenario.Type) -> ViewControllerTestScenario? {
    return ValidationTestScenariosManager.shared.activateScenario(scenario: scenario)
}
