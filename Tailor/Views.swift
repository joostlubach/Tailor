import Foundation

open class ContainerView: UIView {
  public init() {
    super.init(frame: CGRect.zero)
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
  open func setup() {

  }
}

open class ThemedView: UIView {

  public init() {
    super.init(frame: CGRect.zero)
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

  open var theme: Theme? {
    didSet {
      if _applyTheme {
        theme?.applyTo(self)
      }
    }
  }

  /// Override this method for initialization.
  open func setup() {
  }

  private func applyTheme() {
    _applyTheme = true
    theme?.applyTo(self)
  }

}

open class RootView: ThemedView {

  public init(viewController: UIViewController) {
    let window = UIApplication.shared.delegate!.window!!
    self.viewController = viewController
    super.init(frame: window.frame)
  }
  public init(viewController: UIViewController, frame: CGRect) {
    self.viewController = viewController
    super.init(frame: frame)
  }
  required public init?(coder: NSCoder) {
    self.viewController = coder.value(forKey: "viewController") as! UIViewController
    super.init(coder: coder)
  }
  open override func encode(with coder: NSCoder) {
    super.encode(with: coder)
    coder.setValue(viewController, forKey: "viewController")
  }

  open weak var viewController: UIViewController! {
    willSet {
      assert(viewController == nil, "you may not replace the view controller")
    }
  }

}
