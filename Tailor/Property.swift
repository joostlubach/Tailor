import Foundation

public class Property<T>: NSObject {

  typealias Application = (UIView, T) -> Void

  public init(_ name: String) {
    self.name = name
  }

  let name: String

  var applications: [Application] = []

  public func setValue(value: T, forView view: UIView) {
    for application in applications {
      application(view, value)
    }
  }

  public func application<ViewType: UIView>(type: ViewType.Type, block: (ViewType, T) -> Void) {
    applications.append { view, value in
      // TODO: Swift is unable to do a static type cast based on a generic type (view as? ViewType),
      // so we use a runtime type-check on the type of view. Perhaps later this will be fixed.
      if view.isKindOfClass(ViewType.self) {
        block(view as! ViewType, value)
      }
    }
  }

  public func application(block: (UIView, T) -> Void) {
    applications.append(block)
  }

}