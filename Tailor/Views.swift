import UIKit

/// An easy to use view class. Place all initialization code in `setup`.
public class View: UIView {

  public init() {
    super.init(frame: CGRectZero)
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
  public func setup() {
  }
  
}

/// A container view can be used to make sure that themes pass through to their subviews.
public class ContainerView: View, ThemeContainerView {}

/// A themed view can be assigned a theme, which is applied at some crucial points.
public class ThemedView: View, UnthemedView {

  public override init() {
    super.init()
    applyTheme()
  }
  public override init(frame: CGRect) {
    super.init(frame: frame)
    applyTheme()
  }
  public required init?(coder: NSCoder) {
    fatalError("view coding is not supported in Builder classes")
  }

  /// The theme of this view.
  public var theme: Theme? {
    didSet {
      applyTheme()
    }
  }

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
  }

}

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

/// Easy to use base class for table view cells. Place initialization code in `setup`.
public class TableViewCell: UITableViewCell {
  public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
  }
  public required init(coder: NSCoder) {
    fatalError("view coding is not supported in Builder classes")
  }
  public func setup() {}
}

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