import Foundation

open class Theme {

  typealias Handler = (Theme) -> Void

  public convenience init(_ name: String, handler: @escaping (Theme) -> Void) {
    self.init(name, baseTheme: nil, handler: handler)
  }
  public init(_ name: String, baseTheme: Theme?, handler: @escaping (Theme) -> Void) {
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

  open func applyTo(_ themeable: Themeable) {
    currentThemeable = themeable
    currentStylableViews = themeable.stylableViews()

    baseTheme?.applyTo(themeable)
    handler(self)

    currentStylableViews = nil
    currentThemeable = nil
  }

  private func withSelectedViews(_ views: [UIView], _ block: () -> Void) {
    selectedViews = views
    block()
    selectedViews = nil
  }

  open func selectRootView(_ block: () -> Void) {
    let views = currentStylableViews.filter { $0.isRootView }
    withSelectedViews(views, block)
  }

  open func selectAllViews(_ block: () -> Void) {
    assert(currentThemeable != nil, "you cannot select views outside of a theme declaration")
    withSelectedViews(currentStylableViews, block)
  }

  open func selectViewsWithClassName(_ className: String, block: () -> Void) {
    assert(currentThemeable != nil, "you cannot select views outside of a theme declaration")
    let views = currentStylableViews.filter { $0.classNames.filter({ $0 == className }).count > 0 }
    withSelectedViews(views, block)
  }

  open func selectViewsWithAnyClassName(_ classNames: [String], block: () -> Void) {
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

  open func selectViewsWithAllClassNames(_ classNames: [String], block: () -> Void) {
    assert(currentThemeable != nil, "you cannot select views outside of a theme declaration")
    let views = currentStylableViews.filter {
      for name in classNames {
        if $0.classNames.filter({ $0 == name }).count == 0 {
          return false
        }
      }
      return true
    }
    withSelectedViews(views, block)
  }

  open func selectViewsOfType(_ type: UIView.Type, block: () -> Void) {
    assert(currentThemeable != nil, "you cannot select views outside of a theme declaration")
    let views = currentStylableViews.filter { $0.isKind(of: type) }
    withSelectedViews(views, block)
  }

  open func onViewsOfType<T: UIView>(_ type: T.Type, block: (T) -> Void) {
    assert(currentThemeable != nil, "you cannot select views outside of a theme declaration")
    let views = currentStylableViews.filter { $0.isKind(of: type) }

    for view in views as! [T] {
      block(view)
    }
  }

  open func applyCustomStylesToViewsOfType<T: UIView>(_ type: T.Type, block: (T) -> Void) {
    let views = currentStylableViews.filter { $0.isKind(of: type) }
    for view in views {
      block(view as! T)
    }
  }

  open func setValue<T>(_ value: T, forProperty property: Property<T>) {
    assert(selectedViews != nil, "no views selected")

    for view in selectedViews {
      property.setValue(value, forView: view)
    }
  }

  open func addStyle<T>(_ style: Style<T>) {
    assert(selectedViews != nil, "no views selected")

    for view in selectedViews {
      style.applyTo(view)
    }
  }

}

@objc public protocol Themeable {

  func stylableViews() -> [UIView]

}
