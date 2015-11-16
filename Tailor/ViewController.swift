import UIKit

/// A view controller with a typed root view.
public class ViewController<TView: RootView>: UIViewController {

  public init() {
    super.init(nibName: nil, bundle: nil)
  }
  public required init(coder: NSCoder) {
    abort()
  }

  /// Obtains the typed root view.
  public var rootView: TView {
    return view as! TView
  }

  /// Loads the view.
  public override func loadView() {
    let window = UIApplication.sharedApplication().delegate!.window!!
    view = TView(viewController: self, frame: window.frame)
  }

  public override func viewDidLoad() {
    super.viewDidLoad()
  }

}

/// A root view for any view controller.
public class RootView: ThemedView {

  public required init(viewController: UIViewController, frame: CGRect) {
    self.viewController = viewController
    super.init(frame: frame)
  }
  required public init(coder: NSCoder) {
    fatalError("RootView does not support coding")
  }

  /// A reference to the view controller owning this root view.
  public unowned let viewController: UIViewController
  
}