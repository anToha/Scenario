import UIKit

class TestApplicationRootViewController: UINavigationController {
    var firedEventLabelText: String = "" {
        didSet {
            self.eventsReportingLabel?.text = firedEventLabelText
        }
    }
    
    private var eventsReportingLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.isNavigationBarHidden = true
        
        let eventsReportingLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        eventsReportingLabel.accessibilityIdentifier = "eventsReportingLabel"
        self.view.addSubview(eventsReportingLabel)
        self.view.sendSubview(toBack: eventsReportingLabel)
        
        self.eventsReportingLabel = eventsReportingLabel
    }
}
