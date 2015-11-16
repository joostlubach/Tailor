import UIKit

/// A navigation controller supporting theming for its navigation bar.
public class NavigationController: UINavigationController {

  public init() {
    super.init(nibName: nil, bundle: nil)
    applyTheme()
  }
  public override init(nibName: String?, bundle: NSBundle?) {
    super.init(nibName: nibName, bundle: bundle)
    applyTheme()
  }
  public override init(rootViewController: UIViewController) {
    super.init(rootViewController: rootViewController)
    applyTheme()
  }
  public required init(coder: NSCoder) {
    abort()
  }

  /// The theme of the navigation controller.
  public var theme: Theme? {
    didSet {
      applyTheme()
    }
  }

  /// Applies the theme to the navigation bar.
  public func applyTheme() {
    if let theme = self.theme ?? Theme.defaultTheme {
      theme.applyTo(navigationBar)
    }
  }

}
