import UIKit

<<<<<<< Updated upstream
/// An easy to use view class. Place all initialization code in `setup`.
public class View: UIView {

<<<<<<< Updated upstream
=======
open class ContainerView: UIView {
>>>>>>> Stashed changes
=======
open class ContainerView: UIView {
>>>>>>> Stashed changes
  public init() {
    super.init(frame: CGRect.zero)
    setup()
    setupComplete = true
  }
  public override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
    setupComplete = true
  }
  public required init?(coder: NSCoder) {
    fatalError("view coding is not supported in Builder classes")
  }

  public var setupComplete = false

  /// Override this method for initialization.
<<<<<<< Updated upstream
<<<<<<< Updated upstream
  public func setup() {
=======
=======
>>>>>>> Stashed changes
  open func setup() {

>>>>>>> Stashed changes
  }
  
}

<<<<<<< Updated upstream
<<<<<<< Updated upstream
/// A container view can be used to make sure that themes pass through to their subviews.
public class ContainerView: View, ThemeContainerView {}

/// A themed view can be assigned a theme, which is applied at some crucial points.
public class ThemedView: View, UnthemedView {

  public override init() {
    super.init()
=======
=======
>>>>>>> Stashed changes
open class ThemedView: UIView {

  public init() {
    super.init(frame: CGRect.zero)
    setup()
>>>>>>> Stashed changes
    applyTheme()
  }
  public override init(frame: CGRect) {
    super.init(frame: frame)
    applyTheme()
  }
  public required init?(coder: NSCoder) {
    fatalError("view coding is not supported in Builder classes")
  }

<<<<<<< Updated upstream
<<<<<<< Updated upstream
  /// The theme of this view.
  public var theme: Theme? {
=======
  fileprivate var _applyTheme = false

  open var theme: Theme? {
>>>>>>> Stashed changes
=======
  fileprivate var _applyTheme = false

  open var theme: Theme? {
>>>>>>> Stashed changes
    didSet {
      applyTheme()
    }
  }

<<<<<<< Updated upstream
  /// Applies the view's theme, but only after the view set up has been completed.
  public func applyTheme() {
    if setupComplete, let theme = self.theme ?? Theme.defaultTheme {
      theme.applyTo(self)
    }
  }

  public override var styleableBackgroundView: UIView? {
    return self
  }

  // Apply the theme every time a subview is added (unless we're still initializing).

  public override func addSubview(view: UIView) {
    super.addSubview(view)
    applyTheme()
  }

  public override func insertSubview(view: UIView, aboveSubview siblingSubview: UIView) {
    super.insertSubview(view, aboveSubview: siblingSubview)
    applyTheme()
  }

  public override func insertSubview(view: UIView, atIndex index: Int) {
    super.insertSubview(view, atIndex: index)
    applyTheme()
  }

  public override func insertSubview(view: UIView, belowSubview siblingSubview: UIView) {
    super.insertSubview(view, belowSubview: siblingSubview)
    applyTheme()
=======
  /// Override this method for initialization.
  open func setup() {
  }

  fileprivate func applyTheme() {
    _applyTheme = true
    theme?.applyTo(self)
>>>>>>> Stashed changes
  }

}

<<<<<<< Updated upstream
<<<<<<< Updated upstream
/// Easy to use base class for buttons. Place initialization code in `setup`.
public class Button: UIButton {
  public init() {
    super.init(frame: CGRectZero)
    setup()
  }
  public override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  public required init(coder: NSCoder) {
    fatalError("view coding is not supported in Builder classes")
  }
  public func setup() {}
}

/// Easy to use base class for controls. Place initialization code in `setup`.
public class Control: UIControl {
  public init() {
    super.init(frame: CGRectZero)
    setup()
=======
=======
>>>>>>> Stashed changes
open class RootView: ThemedView {

  public init(viewController: UIViewController) {
    let window = UIApplication.shared.delegate!.window!!
    self.viewController = viewController
    super.init(frame: window.frame)
>>>>>>> Stashed changes
  }
  public override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
<<<<<<< Updated upstream
  public required init(coder: NSCoder) {
    fatalError("view coding is not supported in Builder classes")
  }
  public func setup() {}
}

/// Easy to use base class for scroll views. Place initialization code in `setup`.
public class ScrollView: UIScrollView {
  public override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
=======
  required public init?(coder: NSCoder) {
    self.viewController = coder.value(forKey: "viewController") as! UIViewController
    super.init(coder: coder)
  }
  open override func encode(with coder: NSCoder) {
    super.encode(with: coder)
    coder.setValue(viewController, forKey: "viewController")
>>>>>>> Stashed changes
  }
  public required init(coder: NSCoder) {
    fatalError("view coding is not supported in Builder classes")
  }
  public func setup() {}
}

<<<<<<< Updated upstream
<<<<<<< Updated upstream
/// Easy to use base class for table view cells. Place initialization code in `setup`.
public class TableViewCell: UITableViewCell {
  public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
=======
=======
>>>>>>> Stashed changes
  open weak var viewController: UIViewController! {
    willSet {
      assert(viewController == nil, "you may not replace the view controller")
    }
>>>>>>> Stashed changes
  }
  public required init(coder: NSCoder) {
    fatalError("view coding is not supported in Builder classes")
  }
  public func setup() {}
}

<<<<<<< Updated upstream
<<<<<<< Updated upstream
/// Easy to use base class for collection view cells. Place initialization code in `setup`.
public class CollectionViewCell: UICollectionViewCell {
  public init() {
    super.init(frame: CGRectZero)
    setup()
  }
  public override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  public required init(coder: NSCoder) {
    fatalError("view coding is not supported in Builder classes")
  }
  public func setup() {}
}
=======
}
>>>>>>> Stashed changes
=======
}
>>>>>>> Stashed changes
