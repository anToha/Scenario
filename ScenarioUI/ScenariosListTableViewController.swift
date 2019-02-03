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
        return scenariosList.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseID, for: indexPath)

        cell.textLabel?.text = scenariosList[indexPath.row].scenarioName

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.scenariosList[indexPath.row].selectionAction()
    }
}

