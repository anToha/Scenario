import UIKit.UIViewController
import UI
import VCTDDTestScenario

class TestScenarioA: ViewControllerTestScenario {
  
  override func buildViewController() -> UIViewController {
    let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle(identifier: "private.UI"))
    let vc = storyboard.instantiateInitialViewController() as! ViewController
    
    vc.props = self.props()
    return vc
  }
  
  func props() -> ViewController.Props {
    return ("Scenario A", {
      self.reportEventClosure(VCTDDDescribeCalledFunction())
    })
  }
  
}

class TestScenarioB: ViewControllerTestScenario {
  
  override func buildViewController() -> UIViewController {
    let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle(identifier: "private.UI"))
    let vc = storyboard.instantiateInitialViewController() as! ViewController
    
    vc.props = self.props()
    return vc
  }
  
  func props() -> ViewController.Props {
    return ("Scenario B", {
      self.reportEventClosure(VCTDDDescribeCalledFunction())
    })
  }
  
}

