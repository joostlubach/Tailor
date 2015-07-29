import UIKit

private var ThemeObjectKey: Void?
private var ClassNamesObjectKey: Void?

public extension UIView {

  var classNames: [String] {
    get {
      return objc_getAssociatedObject(self, &ClassNamesObjectKey) as? [String] ?? []
    }
    set {
      objc_setAssociatedObject(self, &ClassNamesObjectKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }

  func setValue<T>(value: T, forStyleProperty property: Property<T>) {
    property.setValue(value, forView: self)
  }

  func addStyle<T>(style: Style<T>) {
    style.property.setValue(style.value, forView: self)
  }

  func property<T>(property: Property<T>, wasSetToValue: T) {
  }
  
}

extension UIView: Themeable {

  public func stylableViews() -> [UIView] {
    return ThemeUtility.getAllViewsRecursively(self)
  }

}

extension UITableView {

  public var theme: Theme? {
    get {
      return objc_getAssociatedObject(self, &ThemeObjectKey) as? Theme
    }
    set {
      objc_setAssociatedObject(self, &ThemeObjectKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      newValue?.applyTo(self)
    }
  }

  public override func stylableViews() -> [UIView] {
    var views: [UIView] = [self]
    if let view = backgroundView {
      views += ThemeUtility.getAllViewsRecursively(view)
    }
    return views
  }

}

extension UITableViewCell {

  public override func stylableViews() -> [UIView] {
    var views: [UIView] = [self]

    views.append(imageView!)
    views.append(textLabel!)
    if let label = detailTextLabel {
      label.classNames.append("cell.detail")
      views.append(label)
    }
    if let view = backgroundView {
      view.classNames.append("cell.background")
      views.append(view)
    }
    if let view = selectedBackgroundView {
      view.classNames.append("cell.selected-background")
      views.append(view)
    }

    views += ThemeUtility.getAllViewsRecursively(contentView)

    return views
  }
  
}

extension UICollectionViewCell {

  public override func stylableViews() -> [UIView] {
    var views: [UIView] = [self]

    if let view = backgroundView {
      view.classNames.append("cell.background")
      views.append(view)
    }
    if let view = selectedBackgroundView {
      view.classNames.append("cell.selected-background")
      views.append(view)
    }

    var contentViews = ThemeUtility.getAllViewsRecursively(contentView)
    contentViews.removeAtIndex(0)

    views += contentViews

    return views
  }
  
}