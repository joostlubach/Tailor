import Foundation

/// A theme applies a bunch of styles to a view hierarchy based on rudimentary selectors. Using themes, you can accomplish
/// a unified style with limited code.
public class Theme {

  // MARK: - Initialization

  /// Initializes the theme.
  public init(handler: (Themer) -> Void) {
    self.handler = handler
    self.baseTheme = nil
  }

  /// Initializes the theme with a base theme. The base theme is applied first, before applying this theme.
  public init(baseTheme: Theme, handler: (Themer) -> Void) {
    self.handler = handler
    self.baseTheme = baseTheme
  }



  // MARK: Properties

  /// The theme handler.
  let handler: (Themer) -> Void

  /// An optional base theme for this theme.
  public let baseTheme: Theme?



  // MARK: - Application

  /// Applies the theme to the given themeable.
  public func applyTo(themeable: Themeable) {
    // First apply an optional base theme.
    baseTheme?.applyTo(themeable)

    let themer = Themer(theme: self, themeable: themeable)
    handler(themer)
  }

}

/// A class used to apply a specific theme.
public class Themer {

  init(theme: Theme, themeable: Themeable) {
    self.theme = theme
    self.themeable = themeable
    self.allViews = themeable.resolveStyleableViews()
  }

  /// The theme that is being applied.
  public let theme: Theme

  /// The themeable that is being styled.
  public let themeable: Themeable!

  /// All (styleable) views for the current themeable.
  private let allViews: [UIView]!

  /// The currently selected views.
  private var selectedViews: [UIView]!

  /// Helper to select views, execute a block, and reset.
  private func withSelectedViews(views: [UIView], _ block: (StyleableWrapper) -> Void) {
    for view in selectedViews {
      let wrapper = StyleableWrapper(styleable: view)
      block(wrapper)
    }
  }


  // MARK: - Selectors

  /// Selects the background view in the hierarchy.
  public func withBackgroundView(block: (StyleableWrapper) -> Void) {
    if let view = themeable.styleableBackgroundView {
      withSelectedViews([view], block)
    }
  }

  /// Selects all views in the hierarchy.
  public func withAllViews(block: (StyleableWrapper) -> Void) {
    withSelectedViews(allViews, block)
  }

  /// Selects views that have the given class name.
  public func withViewsWithClassName(className: String, block: (StyleableWrapper) -> Void) {
    let views = viewsWithAnyClassName([className])
    withSelectedViews(views, block)
  }

  /// Selects views that have any of the given class names.
  public func withViewsWithAnyClassName(classNames: [String], block: (StyleableWrapper) -> Void) {
    let views = viewsWithAnyClassName(classNames)
    withSelectedViews(views, block)
  }

  /// Selects views that have all of the given class names.
  public func withViewsWithAllClassNames(classNames: [String], block: (StyleableWrapper) -> Void) {
    let views = viewsWithAllClassNames(classNames)
    withSelectedViews(views, block)
  }

  /// Selects views of a specific type.
  public func withViewsOfType(type: UIView.Type, block: (StyleableWrapper) -> Void) {
    let views = viewsOfType(type)
    withSelectedViews(views, block)
  }


  // MARK: - Style application

  /// Applies the given style to the root view.
  public func applyStyleToBackgroundView(style: Style) {
    if let view = themeable.styleableBackgroundView {
      style.applyTo(view)
    }
  }

  /// Applies the given style to all views.
  public func applyStyleToRootView(style: Style) {
    for view in allViews {
      style.applyTo(view)
    }
  }

  /// Applies the given style to all views with the given class name.
  public func applyStyle(style: Style, toViewsWithClassName className: String) {
    for view in viewsWithAnyClassName([className]) {
      style.applyTo(view)
    }
  }

  /// Applies the given style to all views with any of the given class names.
  public func applyStyle(style: Style, toViewsWithAnyClassName classNames: [String]) {
    for view in viewsWithAnyClassName(classNames) {
      style.applyTo(view)
    }
  }

  /// Applies the given style to all views with all of the given class names.
  public func applyStyle(style: Style, toViewsWithAllClassNames classNames: [String]) {
    for view in viewsWithAllClassNames(classNames) {
      style.applyTo(view)
    }
  }

  /// Applies the given style to all views of the given type.
  public func applyStyle(style: Style, toViewsOfType type: UIView.Type) {
    for view in viewsOfType(type) {
      style.applyTo(view)
    }
  }

  /// Applies the given style to all views of the given type.
  public func applyStyle<T: UIView>(style: StyleFor<T>, toViewsOfType type: T.Type) {
    for view in viewsOfType(type) {
      style.applyTo(view as! T)
    }
  }


  // MARK: - Selection helpers

  /// Obtains all views that have any of the given class names.
  private func viewsWithAnyClassName(classNames: [String]) -> [UIView] {
    return allViews.filter {
      for name in classNames {
        if $0.classNames.filter({ $0 == name }).count > 0 {
          return true
        }
      }
      return false
    }
  }

  /// Obtains all views that have all of the given class names.
  private func viewsWithAllClassNames(classNames: [String]) -> [UIView] {
    return allViews.filter {
      for name in classNames {
        if $0.classNames.filter({ $0 == name }).count == 0 {
          return false
        }
      }
      return true
    }
  }

  /// Obtains all views of the given type.
  private func viewsOfType(type: UIView.Type) -> [UIView] {
    return allViews.filter { $0.isKindOfClass(type) }  }
  }