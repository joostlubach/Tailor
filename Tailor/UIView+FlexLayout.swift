import UIKit

/// A layout item used in methods `column` and `row`.
public enum LayoutItem {

  /// A view with a fixed size.
  case fixed(UIView)

  /// A view with a flexible size.
  case flexible(UIView, Int)

  /// A fixed space.
  case fixedSpace(CGFloat)

  /// A flexible space.
  case flexibleSpace(Int)

}

/// Multiplies fixed spaces and flexible items by the given multiplier.
public func *(layoutItem: LayoutItem, multiplier: Int) -> LayoutItem {
  switch (layoutItem) {
  case .fixed(_):
    // Note: nothing happens here.
    return layoutItem
  case let .flexible(view, flex):
    return LayoutItem.flexible(view, flex * multiplier)
  case let .fixedSpace(space):
    return LayoutItem.fixedSpace(space * CGFloat(multiplier))
  case let .flexibleSpace(flex):
    return LayoutItem.flexibleSpace(flex * multiplier)
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
    return LayoutItem.fixedSpace(self)
  }
}

extension Double: LayoutItemConvertible {
  public func toLayoutItem() -> LayoutItem {
    return LayoutItem.fixedSpace(CGFloat(self))
  }
}

extension Int: LayoutItemConvertible {
  public func toLayoutItem() -> LayoutItem {
    return LayoutItem.fixedSpace(CGFloat(self))
  }
}

extension UIView: LayoutItemConvertible {

  public func fixed(_ view: UIView) -> LayoutItem {
    return LayoutItem.fixed(view)
  }

  public func flexible(_ view: UIView, flex: Int = 1) -> LayoutItem {
    return LayoutItem.flexible(view, flex)
  }

  public func space() -> LayoutItem {
    return LayoutItem.flexibleSpace(1)
  }

  public func space(_ length: CGFloat) -> LayoutItem {
    return LayoutItem.fixedSpace(length)
  }

  public func toLayoutItem() -> LayoutItem {
    return LayoutItem.fixed(self)
  }

}

public extension RootView {

  public func top() -> LayoutItem {
<<<<<<< Updated upstream
    return LayoutItem.FixedSpace(viewController.topLayoutGuide.length)
  }
  public func bottom() -> LayoutItem {
    return LayoutItem.FixedSpace(viewController.bottomLayoutGuide.length)
=======
    if viewController != nil {
      return LayoutItem.fixedSpace(viewController.topLayoutGuide.length)
    } else {
      return LayoutItem.fixedSpace(0)
    }
  }
  public func bottom() -> LayoutItem {
    if viewController != nil {
      return LayoutItem.fixedSpace(viewController.bottomLayoutGuide.length)
    } else {
      return LayoutItem.fixedSpace(0)
    }
>>>>>>> Stashed changes
  }

}

public extension UIView {

  /// Lays out the given items in a column. Each specified view should have the same superview.
  ///
  /// - parameter items:  The items to lay out.
  /// - parameter align:  An optional (horizontal) alignment for the items.
  ///
  /// :Example:
  ///   This example lays out a log in form in the center of their superview.
  ///
  ///     column([space(), usernameField, 10, passwordField, space()], align: .Center)
<<<<<<< Updated upstream
<<<<<<< Updated upstream
  func column(items: [LayoutItemConvertible?], align: AxisAlignment? = nil, wrapCross: Bool = false, wrapAlong: Bool = false, crossPadding: CGFloat = 0) {
    flex(true, items: items, align: align, wrapCross: wrapCross, wrapAlong: wrapAlong, crossPadding: crossPadding)
=======
=======
>>>>>>> Stashed changes
  func column(_ items: [LayoutItemConvertible?], align: AxisAlignment? = nil, wrapSuperview: Bool = false) {
    flex(true, items: items, align: align, wrapSuperview: wrapSuperview)
>>>>>>> Stashed changes
  }

  /// Lays out the given items in a row. Each specified view should have the same superview.
  ///
  /// - parameter items:  The items to lay out.
  /// - parameter align:  An optional (vertical) alignment for the items.
  ///
  /// :Example:
  ///   This example lays out a text field and a submit button at the top of the screen.
  ///
  ///     column([10, flexible(textField), 10, button, 10], align: .Near)
<<<<<<< Updated upstream
<<<<<<< Updated upstream
  func row(items: [LayoutItemConvertible?], align: AxisAlignment? = nil, wrapCross: Bool = false, wrapAlong: Bool = false, crossPadding: CGFloat = 0) {
    flex(false, items: items, align: align, wrapCross: wrapCross, wrapAlong: wrapAlong, crossPadding: crossPadding)
  }

  private func flex(vertical: Bool, items: [LayoutItemConvertible?], align: AxisAlignment?, wrapCross: Bool = false, wrapAlong: Bool = false, crossPadding: CGFloat = 0) {
=======
=======
>>>>>>> Stashed changes
  func row(_ items: [LayoutItemConvertible?], align: AxisAlignment? = nil, wrapSuperview: Bool = false) {
    flex(false, items: items, align: align, wrapSuperview: wrapSuperview)
  }

  fileprivate func flex(_ vertical: Bool, items: [LayoutItemConvertible?], align: AxisAlignment?, wrapSuperview: Bool) {
<<<<<<< Updated upstream
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes
    var views: [UIView]      = []
    var fixedSpace: CGFloat  = 0.0
    var flexes: Int          = 0
    var itemCount = 0

    for item in items {
      if item == nil {
        continue
      }
      itemCount += 1

      switch item!.toLayoutItem() {
      case let .fixed(view):
        views.append(view)
        fixedSpace += (vertical ? view.frame.height : view.frame.width)
      case let .flexible(view, flex):
        views.append(view)
        flexes += flex
      case let .fixedSpace(length):
        fixedSpace += length
      case let .flexibleSpace(flex):
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

    let availableSpace = vertical ? superview.bounds.height : superview.bounds.width
    let flexSpace = flexes == 0 ? 0 : (availableSpace - fixedSpace) / CGFloat(flexes)

    var current = CGFloat(0)
    for item in items {
      if item == nil {
        continue
      }

      switch item!.toLayoutItem() {
      case let .fixed(view):
        if vertical {
          view.position.y = current
        } else {
          view.position.x = current
        }
        current += vertical ? view.frame.height : view.frame.width

      case let .flexible(view, flex):
        if vertical {
          view.height = flexSpace * CGFloat(flex)
          view.position.y = current
        } else {
          view.width = flexSpace * CGFloat(flex)
          view.position.x = current
        }
        current += flexSpace * CGFloat(flex)

      case let .fixedSpace(length):
        current += length

      case let .flexibleSpace(flex):
        current += flexSpace * CGFloat(flex)
      }
    }

<<<<<<< Updated upstream
<<<<<<< Updated upstream
    let crossAxis = vertical ? LayoutAxis.X : LayoutAxis.Y
=======
    // Perform alignment.
    let crossAxis = vertical ? LayoutAxis.x : LayoutAxis.y
>>>>>>> Stashed changes
=======
    // Perform alignment.
    let crossAxis = vertical ? LayoutAxis.x : LayoutAxis.y
>>>>>>> Stashed changes

    // Perform cross wrapping.
    if wrapCross {
      if vertical {
        let maxWidth = views.map({$0.width}).maxElement() ?? 0
        superview.width = maxWidth + 2 * crossPadding
      } else {
        let maxHeight = views.map({$0.height}).maxElement() ?? 0
        superview.height = maxHeight + 2 * crossPadding
      }
    }

    // Perform along wrapping.
    if wrapAlong {
      if vertical {
        superview.height = current
      } else {
        superview.width = current
      }
    }

    // Perform alignment.
    if let alignment = align {
      for view in views {
        view.alignInSuperview(alignment, onAxis: crossAxis, padding: crossPadding)
      }
    }
  }
  
}
