import XCTest
import Scenario

class ValidationTestScenariosManager {
    static let shared = ValidationTestScenariosManager()

    private(set) var reportedEventDescription = ""
    // TODO: remove force unwrapping
    // implicit force unwrapping is here to allow passing eventFiredReporterFunction in init
    private var testScenarios: [TestScenario]!

    init() {
        self.testScenarios = buildTestScenarios(withReportEventClosure: self.eventFiredReporterFunction)
    }

    func eventFiredReporterFunction(eventUniqueDescription: String) {
        self.reportedEventDescription = eventUniqueDescription
    }

    private func getValidationScenarioInstance<Scenario>(scenarioClass: Scenario.Type) -> Scenario? where Scenario : TestScenario {
        let foundScenario = self.testScenarios.first(where: {type(of: $0) == scenarioClass })

        return foundScenario as? Scenario
    }

    func validateEventIsFired(eventToValidate: () -> ()) {
        eventToValidate()
        let lastFiredEventDescription = XCUIApplication().staticTexts["eventsReportingLabel"].label
        let eventToValidateDescription = self.reportedEventDescription
        XCTAssert(lastFiredEventDescription == eventToValidateDescription, "Last fired event mismatch with validated one. \n\n Last fired:\n\(lastFiredEventDescription) \n\n Validated event:\n\(eventToValidateDescription)")
    }

    func activateScenario<Scenario>(scenario: Scenario.Type) -> Scenario where Scenario : TestScenario {
        guard let scenarioInstance = self.getValidationScenarioInstance(scenarioClass: scenario) else {
            fatalError("Could not find scenario of type: \(scenario)")
        }
        XCUIApplication().tables.staticTexts[String(describing: scenario)].tap()
        return scenarioInstance
    }
}

// MARK: helper functions
public func ActivateScenario<Scenario>(scenario: Scenario.Type) -> Scenario where Scenario : TestScenario {
    return ValidationTestScenariosManager.shared.activateScenario(scenario: scenario)
}

public func DeactivateScenario() {
    XCUIApplication().buttons["closeScenarioButton"].tap()
}

public func ValidateScenarioEventIsFired(eventToValidate: @autoclosure () -> ()) {
    ValidationTestScenariosManager.shared.validateEventIsFired(eventToValidate: eventToValidate)
}

