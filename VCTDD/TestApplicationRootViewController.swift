import UIKit

class TestApplicationRootViewController: UINavigationController {
    var firedEventLabelText: String = "" {
        didSet {
            self.eventsReportingLabel?.text = firedEventLabelText
        }
    }
    
    var closeScenarioButtonDidTouch: () -> () = {}
    
    private var eventsReportingLabel: UILabel?
    private var closeScenarioButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.isNavigationBarHidden = true
        
        let screenBounds = UIScreen.main.bounds
        
        let closeScenarioButton = UIButton(type: .custom)
        closeScenarioButton.frame = CGRect(x: 0, y: screenBounds.maxY - 1, width: 1, height: 1)
        closeScenarioButton.accessibilityIdentifier = "closeScenarioButton"
        closeScenarioButton.addTarget(self, action: #selector(closeScenarioButtonDidTouchAction), for: .touchUpInside)
        self.view.addSubview(closeScenarioButton)

        let eventsReportingLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        eventsReportingLabel.accessibilityIdentifier = "eventsReportingLabel"
        self.view.addSubview(eventsReportingLabel)
        self.view.sendSubview(toBack: eventsReportingLabel)

        
        self.eventsReportingLabel = eventsReportingLabel
    }
    
    @objc
    private func closeScenarioButtonDidTouchAction() {
        self.closeScenarioButtonDidTouch()
    }
}
