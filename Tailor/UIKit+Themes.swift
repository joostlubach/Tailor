import UIKit

private var ThemeObjectKey: Void?
private var ClassNamesObjectKey: Void?

public extension UIView {

  var classNames: [String] {
    get {
      return objc_getAssociatedObject(self, &ClassNamesObjectKey) as? [String] ?? []
    }
    set {
      objc_setAssociatedObject(self, &ClassNamesObjectKey, newValue, UInt(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
    }
  }

  var isRootView: Bool {
    return false
  }

  var isContainerView: Bool {
    return false
  }

}

extension ThemedView {

  override public var isRootView: Bool {
    return true
  }

}

extension UITableView {

  override public var isRootView: Bool {
    return true
  }

}

extension UICollectionView {

  override public var isRootView: Bool {
    return true
  }

}

extension ContainerView {

  override public var isContainerView: Bool {
    return true
  }

}

extension UIScrollView {

  override public var isContainerView: Bool {
    return true
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
      objc_setAssociatedObject(self, &ThemeObjectKey, newValue, UInt(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
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

extension UICollectionView {

  public var theme: Theme? {
    get {
      return objc_getAssociatedObject(self, &ThemeObjectKey) as? Theme
    }
    set {
      objc_setAssociatedObject(self, &ThemeObjectKey, newValue, UInt(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
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