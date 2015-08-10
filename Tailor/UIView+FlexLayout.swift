import UIKit

/// A layout item used in methods `column` and `row`.
public enum LayoutItem {

  /// A view with a fixed size.
  case Fixed(UIView)

  /// A view with a flexible size.
  case Flexible(UIView, Int)

  /// A fixed space.
  case FixedSpace(CGFloat)

  /// A flexible space.
  case FlexibleSpace(Int)

}

/// Multiplies fixed spaces and flexible items by the given multiplier.
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

extension LayoutItem: LayoutItemConvertible {
  public func toLayoutItem() -> LayoutItem {
    return self
  }
}

extension CGFloat: LayoutItemConvertible {
  public func toLayoutItem() -> LayoutItem {
    return LayoutItem.FixedSpace(self)
  }
}

extension Double: LayoutItemConvertible {
  public func toLayoutItem() -> LayoutItem {
    return LayoutItem.FixedSpace(CGFloat(self))
  }
}

extension Int: LayoutItemConvertible {
  public func toLayoutItem() -> LayoutItem {
    return LayoutItem.FixedSpace(CGFloat(self))
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

  /// Lays out the given items in a column. Each specified view should have the same superview.
  ///
  /// :param: items  The items to lay out.
  /// :param: align  An optional (horizontal) alignment for the items.
  ///
  /// :Example:
  ///   This example lays out a log in form in the center of their superview.
  ///
  ///     column([space(), usernameField, 10, passwordField, space()], align: .Center)
  func column(items: [LayoutItemConvertible?], align: AxisAlignment? = nil, wrapSuperview: Bool = false) {
    flex(true, items: items, align: align, wrapSuperview: wrapSuperview)
  }

  /// Lays out the given items in a row. Each specified view should have the same superview.
  ///
  /// :param: items  The items to lay out.
  /// :param: align  An optional (vertical) alignment for the items.
  ///
  /// :Example:
  ///   This example lays out a text field and a submit button at the top of the screen.
  ///
  ///     column([10, flexible(textField), 10, button, 10], align: .Near)
  func row(items: [LayoutItemConvertible?], align: AxisAlignment? = nil, wrapSuperview: Bool = false) {
    flex(false, items: items, align: align, wrapSuperview: wrapSuperview)
  }

  private func flex(vertical: Bool, items: [LayoutItemConvertible?], align: AxisAlignment?, wrapSuperview: Bool) {
    var views: [UIView]      = []
    var fixedSpace: CGFloat  = 0.0
    var flexes: Int          = 0
    var itemCount = 0

    for item in items {
      if item == nil {
        continue
      }
      itemCount++

      switch item!.toLayoutItem() {
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
    if itemCount == 0 {
      return
    }

    if views.count == 0 {
      preconditionFailure("need at least one view for column/row layout")
    }
    if views[0].superview == nil {
      preconditionFailure("no superview found")
    }

    let superview = views[0].superview!

    var availableSpace = vertical ? superview.bounds.height : superview.bounds.width
    let flexSpace = flexes == 0 ? 0 : (availableSpace - fixedSpace) / CGFloat(flexes)

    var current = CGFloat(0)
    for item in items {
      if item == nil {
        continue
      }

      switch item!.toLayoutItem() {
      case let .Fixed(view):
        if vertical {
          view.position.y = current
        } else {
          view.position.x = current
        }
        current += vertical ? view.frame.height : view.frame.width

      case let .Flexible(view, flex):
        if vertical {
          view.height = flexSpace * CGFloat(flex)
          view.position.y = current
        } else {
          view.width = flexSpace * CGFloat(flex)
          view.position.x = current
        }
        current += flexSpace * CGFloat(flex)

      case let .FixedSpace(length):
        current += length

      case let .FlexibleSpace(flex):
        current += flexSpace * CGFloat(flex)
      }
    }

    // Perform alignment.
    let crossAxis = vertical ? LayoutAxis.X : LayoutAxis.Y

    if let alignment = align {
      for view in views {
        view.alignInSuperview(alignment, onAxis: crossAxis)
      }
    }

    // Perform wrapping.
    if wrapSuperview {
      if vertical {
        superview.height = current
      } else {
        superview.width = current
      }
    }
  }
  
}
