import XCTest
import ScenarioUtils

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
