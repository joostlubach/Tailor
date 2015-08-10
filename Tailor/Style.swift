import Foundation

public class Style<T> {

  public init(property: Property<T>, value: T) {
    self.property = property
    self.value = value
  }

  public let property: Property<T>
  public let value: T

  public func applyTo(view: UIView) {
    property.setValue(value, forView: view)
  }
  
}