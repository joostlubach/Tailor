import Foundation

public class ContainerView: UIView {
  public init() {
    super.init(frame: CGRectZero)
    setup()
  }
  public override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }

  /// Override this method for initialization.
  public func setup() {

  }

}

public class ThemedView: UIView {

  public init() {
    super.init(frame: CGRectZero)
    setup()
    applyTheme()
  }
  public override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
    applyTheme()
  }
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
    applyTheme()
  }

  private var _applyTheme = false

  public var theme: Theme? {
    didSet {
      if _applyTheme {
        theme?.applyTo(self)
      }
    }
  }

  /// Override this method for initialization.
  public func setup() {
  }

  private func applyTheme() {
    _applyTheme = true
    theme?.applyTo(self)
  }

}

public class RootView: ThemedView {

  public convenience init(viewController: UIViewController) {
    let window = UIApplication.sharedApplication().delegate!.window!!
    self.init(viewController: viewController, frame: window.frame)
  }
  public init(viewController: UIViewController, frame: CGRect) {
    self.viewController = viewController
    super.init(frame: frame)
  }
  required public init?(coder: NSCoder) {
    self.viewController = coder.valueForKey("viewController") as! UIViewController
    super.init(coder: coder)
  }
  public override func encodeWithCoder(coder: NSCoder) {
    super.encodeWithCoder(coder)
    coder.setValue(viewController, forKey: "viewController")
  }

  public weak var viewController: UIViewController! {
    willSet {
      assert(viewController == nil, "you may not replace the view controller")
    }
  }

}