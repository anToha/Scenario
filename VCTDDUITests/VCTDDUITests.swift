import XCTest

class VCTDDUITests: XCTestCase {
    
//    var propsBuilder = TestPropsBuilder { eventDescription in
//        XCTAssert(XCUIApplication().staticTexts["eventsReportingLabel"].label == eventDescription)
//    }
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test01() {
        let validationScenarioA = VCTDDActivateScenario(scenario: TestScenarioA.self) as! TestScenarioA
        
        let app = XCUIApplication()
        app/*@START_MENU_TOKEN@*/.buttons["testButton"]/*[[".buttons[\"Test Button\"]",".buttons[\"testButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        VCTDDValidateEventIsFired(eventToValidate: validationScenarioA.props().buttonPressed())
        
        XCTAssert(app/*@START_MENU_TOKEN@*/.staticTexts["titleLabel"]/*[[".staticTexts[\"Hello\"]",".staticTexts[\"titleLabel\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.label == validationScenarioA.props().title)
        
        VCTDDDeactivateScenario()

        let validationScenarioB = VCTDDActivateScenario(scenario: TestScenarioB.self) as! TestScenarioB
        
        app/*@START_MENU_TOKEN@*/.buttons["testButton"]/*[[".buttons[\"Test Button\"]",".buttons[\"testButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        VCTDDValidateEventIsFired(eventToValidate: validationScenarioB.props().buttonPressed())
        
        XCTAssert(app/*@START_MENU_TOKEN@*/.staticTexts["titleLabel"]/*[[".staticTexts[\"Hello\"]",".staticTexts[\"titleLabel\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.label == validationScenarioB.props().title)
        
        VCTDDDeactivateScenario()
    }
}

