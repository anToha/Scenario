//
//  PropsBuilder.swift
//  View Controllers TDD test
//
//  Created by Anton Ogarkov on 11/5/17.
//  Copyright © 2017 Anton Ogarkov. All rights reserved.
//

import UIKit

class TestPropsBuilder {
    typealias EventReportedClosure = (_ eventUniqueDescription: String) -> ()
    
    let eventReporterClosure: EventReportedClosure
    
    init(eventReporter:@escaping EventReportedClosure) {
        self.eventReporterClosure = eventReporter
    }
    
    func buildProps_ViewController_01() -> ViewController.Props {
        return ("Hello", {self.eventReporterClosure("Button pressed")})
    }
}
