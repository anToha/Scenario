//
//  TestScenarios.swift
//  UITestingApp
//
//  Created by Anton Ogarkov on 11/14/17.
//  Copyright © 2017 Anton Ogarkov. All rights reserved.
//

import UIKit.UIViewController
import UI

class TestScenarioA: ViewControllerTestScenario {
    
    override func buildViewController() -> UIViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle(identifier: "private.UI"))
        let vc = storyboard.instantiateInitialViewController() as! ViewController
        
        vc.props = self.props()
        return vc
    }
    
    func props() -> ViewController.Props {
        return ("Scenario A", {
            self.reportEventClosure(describeCalledFunction())
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
            self.reportEventClosure(describeCalledFunction())
        })
    }
    
}

