import UIKit.UIViewController
import SampleAppUI
import Scenario

class TestScenarioA: TestScenario {
  
  override func buildViewController() -> UIViewController {
    let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle(identifier: "private.UI"))
    let vc = storyboard.instantiateInitialViewController() as! ViewController
    
    vc.props = self.props()
    return vc
  }
  
  func props() -> ViewController.Props {
    return ("Scenario A", {
      self.reportEventClosure(DescribeCalledFunction())
    })
  }
  
}

class TestScenarioB: TestScenario {
  
  override func buildViewController() -> UIViewController {
    let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle(identifier: "private.UI"))
    let vc = storyboard.instantiateInitialViewController() as! ViewController
    
    vc.props = self.props()
    return vc
  }
  
  func props() -> ViewController.Props {
    return ("Scenario B", {
      self.reportEventClosure(DescribeCalledFunction())
    })
  }
  
}

