import Foundation

open class Style<T> {

  public init(property: Property<T>, value: T) {
    self.property = property
    self.value = value
  }

  open let property: Property<T>
  open let value: T

  open func applyTo(_ view: UIView) {
    property.setValue(value, forView: view)
  }
  
}
