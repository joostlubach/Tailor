import UIKit

private var ThemeObjectKey: Void?
private var ClassNamesObjectKey: Void?

public extension UIView {

  var classNames: Set<String> {
    get {
      let array = objc_getAssociatedObject(self, &ClassNamesObjectKey) as? [String] ?? []
      return Set(array)
    }
    set {
      objc_setAssociatedObject(self, &ClassNamesObjectKey, Array(newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }

}

// All UIView's are essentially themeable.
extension UIView: Themeable {

  public var styleableBackgroundView: UIView? {
    return nil
  }

  public func resolveStyleableViews() -> [UIView] {
    return ThemeUtility.getAllViewsRecursively(self)
  }

}

// Scroll views are considered containers.
extension UIScrollView: ThemeContainerView {}

extension UITableView {

  public override var styleableBackgroundView: UIView? {
    return backgroundView ?? self
  }

  public override func resolveStyleableViews() -> [UIView] {
    // For UITableViews, we start at the backgroundView, not the table view itself, as it is invisible.
    var views: [UIView] = [self]
    if let view = backgroundView {
      views += ThemeUtility.getAllViewsRecursively(view)
    }
    return views
  }

}

extension UITableViewCell {

  public override var styleableBackgroundView: UIView? {
    return backgroundView ?? self
  }

  public override func resolveStyleableViews() -> [UIView] {
    // For UITableViewCells, we add some specific views, and we add all views recursively in the content view.
    var views: [UIView] = [self]

    views.append(imageView!)
    views.append(textLabel!)
    if let label = detailTextLabel {
      label.classNames.insert("cell.detail")
      views.append(label)
    }
    if let view = backgroundView {
      view.classNames.insert("cell.background")
      views.append(view)
    }
    if let view = selectedBackgroundView {
      view.classNames.insert("cell.selected-background")
      views.append(view)
    }

    views += ThemeUtility.getAllViewsRecursively(contentView)

    return views
  }
  
}

extension UICollectionViewCell {

  public override var styleableBackgroundView: UIView? {
    return backgroundView ?? self
  }

  public override func resolveStyleableViews() -> [UIView] {
    // For UICollectionViewCells, we add some specific views, and we add all views recursively in the content view.
    var views: [UIView] = [self]

    if let view = backgroundView {
      view.classNames.insert("cell.background")
      views.append(view)
    }
    if let view = selectedBackgroundView {
      view.classNames.insert("cell.selected-background")
      views.append(view)
    }

    var contentViews = ThemeUtility.getAllViewsRecursively(contentView)
    contentViews.removeAtIndex(0)

    views += contentViews

    return views
  }
  
}