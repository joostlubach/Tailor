import Foundation

public class Theme {

  typealias Handler = (Theme) -> Void

  public convenience init(_ name: String, handler: (Theme) -> Void) {
    self.init(name, baseTheme: nil, handler: handler)
  }
  public init(_ name: String, baseTheme: Theme?, handler: (Theme) -> Void) {
    self.name = name
    self.handler = handler
    self.baseTheme = baseTheme
  }

  let name: String
  let handler: Handler
  let baseTheme: Theme?

  var currentThemeable: Themeable!
  var currentStylableViews: [UIView]!
  var selectedViews: [UIView]!

  public func applyTo(themeable: Themeable) {
    currentThemeable = themeable
    currentStylableViews = themeable.stylableViews()

    baseTheme?.applyTo(themeable)
    handler(self)

    currentStylableViews = nil
    currentThemeable = nil
  }

  private func withSelectedViews(views: [UIView], _ block: () -> Void) {
    selectedViews = views
    block()
    selectedViews = nil
  }

  public func selectRootView(block: () -> Void) {
    selectViewsOfType(RootView.self, block: block)
    selectViewsOfType(ThemedView.self, block: block)
  }

  public func selectAllViews(block: () -> Void) {
    assert(currentThemeable != nil, "you cannot select views outside of a theme declaration")
    withSelectedViews(currentStylableViews, block)
  }

  public func selectViewsWithClassName(className: String, block: () -> Void) {
    assert(currentThemeable != nil, "you cannot select views outside of a theme declaration")
    let views = currentStylableViews.filter { $0.classNames.filter({ $0 == className }).count > 0 }
    withSelectedViews(views, block)
  }

  public func selectViewsWithClassNames(classNames: [String], block: () -> Void) {
    assert(currentThemeable != nil, "you cannot select views outside of a theme declaration")
    let views = currentStylableViews.filter {
      for name in classNames {
        if $0.classNames.filter({ $0 == name }).count > 0 {
          return true
        }
      }
      return false
    }
    withSelectedViews(views, block)
  }

  public func selectViewsOfType(type: UIView.Type, block: () -> Void) {
    assert(currentThemeable != nil, "you cannot select views outside of a theme declaration")
    let views = currentStylableViews.filter { $0.isKindOfClass(type) }
    withSelectedViews(views, block)
  }

  public func onViewsOfType<T: UIView>(type: T.Type, block: (T) -> Void) {
    assert(currentThemeable != nil, "you cannot select views outside of a theme declaration")
    let views = currentStylableViews.filter { $0.isKindOfClass(type) }

    for view in views as! [T] {
      block(view)
    }
  }

  public func applyCustomStylesToViewsOfType<T: UIView>(type: T.Type, block: (T) -> Void) {
    let views = currentStylableViews.filter { $0.isKindOfClass(type) }
    for view in views {
      block(view as! T)
    }
  }

  public func setValue<T>(value: T, forProperty property: Property<T>) {
    assert(selectedViews != nil, "no views selected")

    for view in selectedViews {
      property.setValue(value, forView: view)
    }
  }

  public func addStyle<T>(style: Style<T>) {
    assert(selectedViews != nil, "no views selected")

    for view in selectedViews {
      style.applyTo(view)
    }
  }

}

@objc public protocol Themeable {
  func stylableViews() -> [UIView]
}