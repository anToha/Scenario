import UIKit.UIViewController
import ExampleUI
import Scenario

class TestScenarioA: TestScenario {
  
  override func buildViewController() -> UIViewController {
    let vc = ViewController.instantiate()
    
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
    let vc = ViewController.instantiate()

    vc.props = self.props()
    return vc
  }
  
  func props() -> ViewController.Props {
    return ("Scenario B", {
      self.reportEventClosure(DescribeCalledFunction())
    })
  }
  
}

