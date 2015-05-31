import UIKit

private func maxOf<T: SequenceType where T.Generator.Element: Comparable>(values: T) -> T.Generator.Element? {
  var currentMax: T.Generator.Element?

  for value in values {
    if currentMax == nil || value > currentMax! {
      currentMax = value
    }
  }

  return currentMax
}

private func minOf<T: SequenceType where T.Generator.Element: Comparable>(values: T) -> T.Generator.Element? {
  var currentMin: T.Generator.Element?

  for value in values {
    if currentMin == nil || value < currentMin! {
      currentMin = value
    }
  }

  return currentMin
}

public extension UIView {

  enum LayoutAxis {
    case X, Y, Both

    var horizontal: Bool {
      return self == X || self == Both
    }
    var vertical: Bool {
      return self == Y || self == Both
    }
  }

  enum LayoutAlignment {
    case Near, Center, Far, Stretch
  }

  // MARK: - Placement

  func place(view: UIView, toTheRightOf otherViews: [UIView], padding: CGFloat = 0) {
    view.frame.origin.x = (maxOf(otherViews.map({ $0.frame.maxX })) ?? 0) + padding
  }
  func place(view: UIView, toTheLeftOf otherViews: [UIView], padding: CGFloat = 0) {
    view.frame.origin.x = (minOf(otherViews.map({ $0.frame.minX })) ?? 0) - view.frame.width - padding
  }
  func place(view: UIView, below otherViews: [UIView], padding: CGFloat = 0) {
    view.frame.origin.y = (maxOf(otherViews.map({ $0.frame.maxY })) ?? 0) + padding
  }
  func place(view: UIView, above otherViews: [UIView], padding: CGFloat = 0) {
    view.frame.origin.y = (minOf(otherViews.map({ $0.frame.minY })) ?? 0) - view.frame.height - padding
  }

  // MARK: - Sizing

  func wrap(view: UIView, around otherViews: [UIView]? = nil, onAxis axis: LayoutAxis = .Both, padding: CGFloat = 0, alignSubviews: LayoutAlignment = .Center) {
    let subviews = otherViews ?? (view.subviews as! [UIView])

    if axis.horizontal {
      var maxWidth = maxOf(subviews.map({ $0.frame.width })) ?? 0
      view.frame.size.width = maxWidth + 2 * padding
    }
    if axis.vertical {
      var maxHeight = maxOf(subviews.map({ $0.frame.height })) ?? 0
      view.frame.size.height = maxHeight + 2 * padding
    }

    // Align the subviews.
    for subview in subviews {
      alignInSuperview(subview, alignment: alignSubviews, onAxis: axis, padding: padding)
    }
  }

  // MARK: - Sizing

  func center(view: UIView, with otherView: UIView, onAxis axis: LayoutAxis = .Both) {
    align(view, alignment: .Center, with: otherView, onAxis: axis)
  }

  func align(view: UIView, alignment: LayoutAlignment, with otherView: UIView, onAxis axis: LayoutAxis = .Both) {
    switch alignment {
    case .Near:
      if axis.horizontal {
        view.frame.origin.x = otherView.frame.minX
      }
      if axis.vertical {
        view.frame.origin.y = otherView.frame.minY
      }
    case .Center:
      if axis.horizontal {
        view.center.x = otherView.center.x
      }
      if axis.vertical {
        view.center.y = otherView.center.y
      }
    case .Far:
      if axis.horizontal {
        view.frame.origin.x = otherView.frame.maxX - view.frame.width
      }
      if axis.vertical {
        view.frame.origin.y = otherView.frame.maxY - view.frame.height
      }
    case .Stretch:
      if axis.horizontal {
        view.frame.origin.x = otherView.frame.minX
        view.frame.size.width = otherView.frame.width
      }
      if axis.vertical {
        view.frame.origin.y = otherView.frame.minY
        view.frame.size.height = otherView.frame.height
      }
    }
  }

  func alignInSuperview(view: UIView, alignment: LayoutAlignment, onAxis axis: LayoutAxis, padding: CGFloat = 0.0) {
    assert(view.superview != nil, "subview must have a superview")

    let superview = view.superview!

    switch alignment {
    case .Near:
      if axis.horizontal {
        view.frame.origin.x = superview.bounds.minX + padding
      }
      if axis.vertical {
        view.frame.origin.y = superview.bounds.minY + padding
      }
    case .Center:
      if axis.horizontal {
        view.center.x = superview.bounds.midX
      }
      if axis.vertical {
        view.center.y = superview.bounds.midY
      }
    case .Far:
      if axis.horizontal {
        view.frame.origin.x = superview.bounds.maxX - padding - view.frame.width
      }
      if axis.vertical {
        view.frame.origin.y = superview.bounds.maxY - padding - view.frame.height
      }
    case .Stretch:
      if axis.horizontal {
        view.frame.origin.x = superview.bounds.minX + padding
        view.frame.size.width = superview.bounds.width - 2 * padding
      }
      if axis.vertical {
        view.frame.origin.y = superview.bounds.minY + padding
        view.frame.size.height = superview.bounds.height - 2 * padding
      }
    }
  }

  func overlay(view: UIView, on otherView: UIView, onAxis axis: LayoutAxis = .Both) {
    if axis.horizontal {
      view.frame.origin.x = otherView.frame.origin.x
      view.frame.size.width = otherView.frame.width
    }
    if axis.horizontal {
      view.frame.origin.y = otherView.frame.origin.y
      view.frame.size.height = otherView.frame.height
    }
  }

}
