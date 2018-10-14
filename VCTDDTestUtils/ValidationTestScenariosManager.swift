import XCTest
import VCTDDTestScenario

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

    private func getValidationScenarioInstance<Scenario>(scenarioClass: Scenario.Type) -> Scenario? where Scenario : ViewControllerTestScenario {

        // TODO: avoid index usage.
        guard let scenarioIndex = self.scenarioIndex(scenario: scenarioClass) else {
            return nil
        }
        return self.testScenariosRegistry.testScenarios[scenarioIndex] as? Scenario
    }

    func validateEventIsFired(eventToValidate: () -> ()) {
        eventToValidate()
        let lastFiredEventDescription = XCUIApplication().staticTexts["eventsReportingLabel"].label
        let eventToValidateDescription = self.reportedEventDescription
        XCTAssert(lastFiredEventDescription == eventToValidateDescription, "Last fired event mismatch with validated one. \n\n Last fired:\n\(lastFiredEventDescription) \n\n Validated event:\n\(eventToValidateDescription)")
    }

    func activateScenario<Scenario>(scenario: Scenario.Type) -> Scenario where Scenario : ViewControllerTestScenario {
        guard let scenarioInstance = self.getValidationScenarioInstance(scenarioClass: scenario) else {
            fatalError("Could not find scenario of type: \(scenario)")
        }
        XCUIApplication().tables.staticTexts[String(describing: scenario)].tap()
        return scenarioInstance
    }
}

// helper functions
public func VCTDDActivateScenario<Scenario>(scenario: Scenario.Type) -> Scenario where Scenario : ViewControllerTestScenario {
    return ValidationTestScenariosManager.shared.activateScenario(scenario: scenario)
}

public func VCTDDDeactivateScenario() {
    XCUIApplication().buttons["closeScenarioButton"].tap()
}

public func VCTDDValidateEventIsFired(eventToValidate: @autoclosure () -> ()) {
    ValidationTestScenariosManager.shared.validateEventIsFired(eventToValidate: eventToValidate)
}
