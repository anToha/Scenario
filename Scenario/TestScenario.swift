import Foundation
import UIKit.UIViewController

public func DescribeCalledFunction(inFile: String = #file,
                                   function: String = #function,
                                   line: Int = #line,
                                   column: Int = #column) -> String {

    return "File: \(inFile) Function: \(function) Line: \(line) Column: \(column)"
}

open class TestScenario {
    public let reportEventClosure: (_ uniqueEventDescription: String)->()

    public required init(reportEventClosure: @escaping (_ uniqueEventDescription: String)->()) {
        self.reportEventClosure = reportEventClosure
    }

    open func buildViewController() -> UIViewController {
        preconditionFailure("Implement this method in subclass.")
    }
}

