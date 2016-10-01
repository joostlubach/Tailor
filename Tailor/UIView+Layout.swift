import UIKit

private func maxOf<T: Sequence>(_ values: T) -> T.Iterator.Element? where T.Iterator.Element: Comparable {
  var currentMax: T.Iterator.Element?

  for value in values {
    if currentMax == nil || value > currentMax! {
      currentMax = value
    }
  }

  return currentMax
}

private func minOf<T: Sequence>(_ values: T) -> T.Iterator.Element? where T.Iterator.Element: Comparable {
  var currentMin: T.Iterator.Element?

  for value in values {
    if currentMin == nil || value < currentMin! {
      currentMin = value
    }
  }

  return currentMin
}

public enum LayoutAxis {
  case x, y, both

  var horizontal: Bool {
    return self == LayoutAxis.x || self == LayoutAxis.both
  }
  var vertical: Bool {
    return self == LayoutAxis.y || self == LayoutAxis.both
  }
}

public enum AxisAlignment {
  case near, center, far, stretch
}

public enum LayoutAlignment {
  case topLeft
  case top
  case topRight
  case left
  case fill
  case right
  case bottomLeft
  case bottom
  case bottomRight

  case topCenter
  case leftCenter
  case center
  case rightCenter
  case bottomCenter

  var horizontalAlignment: AxisAlignment {
    switch self {
    case .topLeft, .left, .leftCenter, .bottomLeft: return .near
    case .top, .fill, .bottom: return .stretch
    case .topCenter, .center, .bottomCenter: return .center
    case .topRight, .right, .rightCenter, .bottomRight: return .far
    }
  }

  var verticalAlignment: AxisAlignment {
    switch self {
    case .topLeft, .top, .topCenter, .topRight: return .near
    case .left, .fill, .right: return .stretch
    case .leftCenter, .center, .rightCenter: return .center
    case .bottomLeft, .bottom, .bottomCenter, .bottomRight: return .far
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

  /// Aligns this view with another view.
  func alignWith(_ otherView: UIView, alignment: LayoutAlignment, padding: CGFloat = 0.0) {
    alignWith(otherView, alignment: alignment.horizontalAlignment, onAxis: .x, padding: padding)
    alignWith(otherView, alignment: alignment.verticalAlignment, onAxis: .y, padding: padding)
  }

  /// Aligns this view with another view on an axis.
  func alignWith(_ otherView: UIView, alignment: AxisAlignment, onAxis axis: LayoutAxis, padding: CGFloat = 0.0) {

    if axis.horizontal {
      switch alignment {
      case .near:
        position.x = otherView.frame.minX + padding
      case .center:
        center.x = otherView.frame.midX
      case .far:
        position.x = otherView.frame.maxX - padding - width
      case .stretch:
        width = otherView.width - 2 * padding
        position.x = otherView.frame.minX + padding
      }
    }

    if axis.vertical {
      switch alignment {
      case .near:
        position.y = otherView.frame.minY + padding
      case .center:
        center.y = otherView.frame.midY
      case .far:
        position.y = otherView.frame.maxY - padding - height
      case .stretch:
        height = otherView.height - 2 * padding
        position.y = otherView.frame.minY + padding
      }
    }

  }

  /// Wraps this view around its subviews on the given axis.
  ///
  /// - parameter axis:     The axis to use for wrapping. By default, this is both axes.
  /// - parameter padding:  An optional padding between the edges of the view and its subviews.
  func wrapAroundSubviews(axis: LayoutAxis = .both, padding: CGFloat = 0) {
    let subviews = self.subviews 

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
    alignInSuperview(.center)
  }

  /// Aligns this view in its superview on the given axis, according to the given alignment.
  func alignInSuperview(_ alignment: AxisAlignment, onAxis axis: LayoutAxis, padding: CGFloat = 0.0) {
    precondition(self.superview != nil)
    let superview = self.superview!

    if axis.horizontal {
      switch alignment {
      case .near:
        position.x = padding
      case .center:
        center.x = superview.width / 2
      case .far:
        position.x = superview.width - width - padding
      case .stretch:
        width = superview.width - 2 * padding
        position.x = padding
      }
    }

    if axis.vertical {
      switch alignment {
      case .near:
        position.y = padding
      case .center:
        center.y = superview.height / 2
      case .far:
        position.y = superview.height - height - padding
      case .stretch:
        height = superview.height - 2 * padding
        position.y = padding
      }
    }
  }

  /// Aligns this view in its superview according to the given alignment.
  func alignInSuperview(_ alignment: LayoutAlignment, padding: CGFloat = 0.0) {
    alignInSuperview(alignment.horizontalAlignment, onAxis: .x, padding: padding)
    alignInSuperview(alignment.verticalAlignment, onAxis: .y, padding: padding)
  }

}
