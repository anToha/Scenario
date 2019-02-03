import UIKit

public class ViewController: UIViewController {
  public static func instantiate() -> ViewController {
    let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle(for: self))
    return storyboard.instantiateInitialViewController() as! ViewController
  }

  public typealias Props = (
    title: String,
    buttonPressed: () -> ()
  )

  public var props: Props = ("", {}) {
    didSet {
      if self.view != nil {
        self.titleLabel.text = props.title
      }
    }
  }

  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    self.titleLabel.text = props.title
  }

  @IBOutlet weak var titleLabel: UILabel!

  @IBAction func testButtonTouched(_ sender: Any) {
    self.props.buttonPressed()
  }
}

