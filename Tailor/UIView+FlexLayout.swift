import UIKit

public enum LayoutItem {
  case Fixed(UIView)
  case Flexible(UIView, Int)
  case FixedSpace(CGFloat)
  case FlexibleSpace(Int)
}

public func *(layoutItem: LayoutItem, multiplier: Int) -> LayoutItem {
  switch (layoutItem) {
  case .Fixed(_):
    // Note: nothing happens here.
    return layoutItem
  case let .Flexible(view, flex):
    return LayoutItem.Flexible(view, flex * multiplier)
  case let .FixedSpace(space):
    return LayoutItem.FixedSpace(space * CGFloat(multiplier))
  case let .FlexibleSpace(flex):
    return LayoutItem.FlexibleSpace(flex * multiplier)
  }
}

public protocol LayoutItemConvertible {
  func toLayoutItem() -> LayoutItem
}

extension CGFloat: LayoutItemConvertible {
  public func toLayoutItem() -> LayoutItem {
    return LayoutItem.FixedSpace(self)
  }
}

extension LayoutItem: LayoutItemConvertible {
  public func toLayoutItem() -> LayoutItem {
    return self
  }
}

extension UIView: LayoutItemConvertible {

  public func fixed(view: UIView) -> LayoutItem {
    return LayoutItem.Fixed(view)
  }

  public func flexible(view: UIView, flex: Int = 1) -> LayoutItem {
    return LayoutItem.Flexible(view, flex)
  }

  public func space() -> LayoutItem {
    return LayoutItem.FlexibleSpace(1)
  }

  public func space(length: CGFloat) -> LayoutItem {
    return LayoutItem.FixedSpace(length)
  }

  public func toLayoutItem() -> LayoutItem {
    return LayoutItem.Fixed(self)
  }

}

public extension RootView {

  public func top() -> LayoutItem {
    return LayoutItem.FixedSpace(viewController.topLayoutGuide.length)
  }
  public func bottom() -> LayoutItem {
    return LayoutItem.FixedSpace(viewController.bottomLayoutGuide.length)
  }

}

public extension UIView {

  func column(items: [LayoutItemConvertible], align: LayoutAlignment, spacing: CGFloat = 0, padding: CGFloat = 0, crossPadding: CGFloat = 0, wrapSuperview: Bool = false) {
    flex(true, items: items, align: align, spacing: spacing, padding: padding, crossPadding: crossPadding, wrapSuperview: wrapSuperview)
  }

  func row(items: [LayoutItemConvertible], align: LayoutAlignment, spacing: CGFloat = 0, padding: CGFloat = 0, crossPadding: CGFloat = 0, wrapSuperview: Bool = false) {
    flex(false, items: items, align: align, spacing: spacing, padding: padding, crossPadding: crossPadding, wrapSuperview: wrapSuperview)
  }

  private func flex(vertical: Bool, items: [LayoutItemConvertible], align: LayoutAlignment, spacing: CGFloat = 0, padding: CGFloat = 0, crossPadding: CGFloat = 0, wrapSuperview: Bool = false) {
    var views: [UIView]      = []
    var fixedSpace: CGFloat  = 0.0
    var flexes: Int          = 0

    for item in items {
      switch item.toLayoutItem() {
      case let .Fixed(view):
        views.append(view)
        fixedSpace += (vertical ? view.frame.height : view.frame.width)
      case let .Flexible(view, flex):
        views.append(view)
        flexes += flex
      case let .FixedSpace(length):
        fixedSpace += length
      case let .FlexibleSpace(flex):
        flexes += flex
      }
    }

    if views.count == 0 {
      assertionFailure("need at least one view for column/row layout")
    }
    if views[0].superview == nil {
      assertionFailure("no superview found")
    }

    let superview = views[0].superview!

    var availableSpace = vertical ? superview.bounds.height : superview.bounds.width
    availableSpace -= 2 * padding

    let totalSpacing = spacing * CGFloat(items.count - 1)

    let flexSpace = flexes == 0 ? 0 : (availableSpace - fixedSpace - totalSpacing) / CGFloat(flexes)

    var current = padding
    for item in items {
      switch item.toLayoutItem() {
      case let .Fixed(view):
        if vertical {
          view.frame.origin.y = current
        } else {
          view.frame.origin.x = current
        }
        current += vertical ? view.frame.height : view.frame.width

      case let .Flexible(view, flex):
        if vertical {
          view.frame.origin.y = current
          view.frame.size.height = flexSpace * CGFloat(flex)
        } else {
          view.frame.origin.x = current
          view.frame.size.width = flexSpace * CGFloat(flex)
        }
        current += flexSpace * CGFloat(flex)

      case let .FixedSpace(length):
        current += length

      case let .FlexibleSpace(flex):
        current += flexSpace * CGFloat(flex)
      }

      current += spacing
    }

    // Perform cross alignment.
    let crossAxis = vertical ? LayoutAxis.X : LayoutAxis.Y
    if wrapSuperview {
      wrap(superview, around: views, onAxis: crossAxis, alignSubviews: align, padding: crossPadding)
      if vertical {
        superview.frame.size.height = fixedSpace + CGFloat(flexes) * flexSpace + totalSpacing + 2 * padding
      } else {
        superview.frame.size.width = fixedSpace + CGFloat(flexes) * flexSpace + totalSpacing + 2 * padding
      }
    } else {
      for view in views {
        alignInSuperview(view, alignment: align, onAxis: crossAxis, padding: crossPadding)
      }
    }
  }
  
}
