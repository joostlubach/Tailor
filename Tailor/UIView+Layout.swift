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

public enum LayoutAxis {
  case X, Y, Both

  var horizontal: Bool {
    return self == X || self == Both
  }
  var vertical: Bool {
    return self == Y || self == Both
  }
}

public enum AxisAlignment {
  case Near, Center, Far, Stretch
}

public enum LayoutAlignment {
  case TopLeft
  case Top
  case TopRight
  case Left
  case Fill
  case Right
  case BottomLeft
  case Bottom
  case BottomRight

  case TopCenter
  case LeftCenter
  case Center
  case RightCenter
  case BottomCenter

  var horizontalAlignment: AxisAlignment {
    switch self {
    case TopLeft, Left, LeftCenter, BottomLeft: return .Near
    case Top, Fill, Bottom: return .Stretch
    case TopCenter, Center, BottomCenter: return .Center
    case TopRight, Right, RightCenter, BottomRight: return .Far
    }
  }

  var verticalAlignment: AxisAlignment {
    switch self {
    case TopLeft, Top, TopCenter, TopRight: return .Near
    case Left, Fill, Right: return .Stretch
    case LeftCenter, Center, RightCenter: return .Center
    case BottomLeft, Bottom, BottomCenter, BottomRight: return .Far
    }
  }
}

// MARK: - Size accessors

public extension UIView {

  var size: CGSize {
    get { return bounds.size }
    set { bounds.size = newValue }
  }

  var width: CGFloat {
    get { return size.width }
    set { size.width = newValue }
  }

  var height: CGFloat {
    get { return size.height }
    set { size.height = newValue }
  }

  var position: CGPoint {
    get {
      return CGPoint(x: center.x - width / 2, y: center.y - height / 2)
    }
    set {
      center = CGPoint(x: newValue.x + width / 2, y: newValue.y + height / 2)
    }
  }

}

public extension UIView {

  /// Sizes this view to fit, unless it is hidden, in which case it gets `CGSizeZero`.
  func sizeToFitWhenShown() {
    if hidden {
      size = CGSizeZero
    } else {
      sizeToFit()
    }
  }

  /// Aligns this view with another view.
  func alignWith(otherView: UIView, alignment: LayoutAlignment) {
    alignWith(otherView, alignment: alignment.horizontalAlignment, onAxis: .X)
    alignWith(otherView, alignment: alignment.verticalAlignment, onAxis: .Y)
  }

  /// Aligns this view with another view on an axis.
  func alignWith(otherView: UIView, alignment: AxisAlignment, onAxis axis: LayoutAxis) {

    if axis.horizontal {
      switch alignment {
      case .Near:
        position.x = otherView.frame.minX
      case .Center:
        center.x = otherView.frame.midX
      case .Far:
        position.x = otherView.frame.maxX - width
      case .Stretch:
        width = otherView.width
        position.x = otherView.frame.minX
      }
    }

    if axis.vertical {
      switch alignment {
      case .Near:
        position.y = otherView.frame.minY
      case .Center:
        center.y = otherView.frame.midY
      case .Far:
        position.y = otherView.frame.maxY - height
      case .Stretch:
        height = otherView.height
        position.y = otherView.frame.minY
      }
    }

  }

  /// Wraps this view around its subviews on the given axis.
  ///
  /// - parameter axis:     The axis to use for wrapping. By default, this is both axes.
  /// - parameter padding:  An optional padding between the edges of the view and its subviews.
  func wrapAroundSubviews(axis: LayoutAxis = .Both, padding: CGFloat = 0) {
    if axis.horizontal {
      size.width = maxOf(subviews.map({ $0.width })) ?? 0
      size.width += 2 * padding

      for view in subviews {
        view.position.x += padding
      }
    }
    if axis.vertical {
      size.height = maxOf(subviews.map({ $0.height })) ?? 0
      size.height += 2 * padding

      for view in subviews {
        view.position.y += padding
      }
    }
  }

  /// Makes this view fill its superview's bounds.
  func fillSuperview() {
    precondition(superview != nil)

    size = superview!.size
    position = CGPoint(x: 0, y: 0)
  }

  /// Centers this view in its superview.
  func centerInSuperview() {
    alignInSuperview(.Center)
  }

  /// Aligns this view in its superview on the given axis, according to the given alignment.
  func alignInSuperview(alignment: AxisAlignment, onAxis axis: LayoutAxis, padding: CGFloat = 0.0) {
    precondition(self.superview != nil)
    let superview = self.superview!

    if axis.horizontal {
      switch alignment {
      case .Near:
        position.x = padding
      case .Center:
        center.x = superview.width / 2
      case .Far:
        position.x = superview.width - width - padding
      case .Stretch:
        width = superview.width - 2 * padding
        position.x = padding
      }
    }

    if axis.vertical {
      switch alignment {
      case .Near:
        position.y = padding
      case .Center:
        center.y = superview.height / 2
      case .Far:
        position.y = superview.height - height - padding
      case .Stretch:
        height = superview.height - 2 * padding
        position.y = padding
      }
    }
  }

  /// Aligns this view in its superview according to the given alignment.
  func alignInSuperview(alignment: LayoutAlignment, padding: CGFloat = 0.0) {
    alignInSuperview(alignment.horizontalAlignment, onAxis: .X, padding: padding)
    alignInSuperview(alignment.verticalAlignment, onAxis: .Y, padding: padding)
  }

}
