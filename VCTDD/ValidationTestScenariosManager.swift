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
}

func validateEventIsFired(eventToValidate: @autoclosure () -> () -> ()) {
    eventToValidate()()
    XCTAssert(XCUIApplication().staticTexts["eventsReportingLabel"].label == ValidationTestScenariosManager.shared.reportedEventDescription)
}

func activateScenario(scenario: ViewControllerTestScenario.Type) -> ViewControllerTestScenario? {
    CHECK THAT SCENARIO IS PRESENT
    XCUIApplication().tables.staticTexts[String(describing: scenario)].tap()
    RETURN SCENARIO
}
