//
//  ScenariosListTableViewController.swift
//  UITestingApp
//
//  Created by Anton Ogarkov on 11/12/17.
//  Copyright © 2017 Anton Ogarkov. All rights reserved.
//

import UIKit

class ScenariosListTableViewController: UITableViewController {

    typealias Scenario = (scenarioName: String, selectionAction:()->())
    var scenariosList: [Scenario] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    let reuseID = "ScenarioCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.reuseID)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return scenariosList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath)
        
        cell.textLabel?.text = scenariosList[indexPath.row].scenarioName

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.scenariosList[indexPath.row].selectionAction()
    }
}
