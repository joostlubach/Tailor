import UIKit

/// Protocol for any object that is themeable.
public protocol Themeable {

  /// The view that is considered the background view of the themeable object.
  var styleableBackgroundView: UIView? { get }

  /// Resolves all styleable views in this themeable object.
  func resolveStyleableViews() -> [UIView]

}

/// If a view conforms to this protocol, it means that its subviews are added when recursively adding views.
public protocol ThemeContainerView {
}

/// If a view conforms to this protocol, it means that it and its subviews are not included when recursively
/// adding views.
public protocol UnthemedView {
}