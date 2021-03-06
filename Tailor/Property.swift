import Foundation

open class Property<T>: NSObject {

  typealias Application = (UIView, T) -> Void

  public init(_ name: String) {
    self.name = name
  }

  let name: String

  var applications: [Application] = []

  open func setValue(_ value: T, forView view: UIView) {
    for application in applications {
      application(view, value)
    }
  }

  open func application<ViewType: UIView>(_ type: ViewType.Type, block: @escaping (ViewType, T) -> Void) {
    applications.append { view, value in
      // TODO: Swift is unable to do a static type cast based on a generic type (view as? ViewType),
      // so we use a runtime type-check on the type of view. Perhaps later this will be fixed.
      if view.isKind(of: ViewType.self) {
        block(view as! ViewType, value)
      }
    }
  }

  open func application(_ block: @escaping (UIView, T) -> Void) {
    applications.append(block)
  }

}
