//
//  ViewController.swift
//  View Controllers TDD test
//
//  Created by Anton Ogarkov on 11/5/17.
//  Copyright © 2017 Anton Ogarkov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    public typealias Props = (
        title: String,
        buttonPressed: () -> ()
    )
    
    public var props: Props = ("", {}) {
        didSet {
            self.titleLabel.text = props.title
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func testButtonTouched(_ sender: Any) {
        self.props.buttonPressed()
    }
}

