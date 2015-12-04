import UIKit

// This file contains the protocols styleable objects can conform to.

public protocol BackgroundStyleable: class {
  var style_opacity: CGFloat { get set }
  var style_backgroundColor: UIColor? { get set }
}

public protocol ForegroundStyleable: class {
  var style_foregroundColor: UIColor? { get set }
}

public protocol BorderStyleable: class {
  var style_borderColor: UIColor? { get set }
  var style_borderWidth: CGFloat { get set }
}

public protocol CornerStyleable: class {
  var style_cornerRadius: CGFloat { get set }
}

public protocol ShadowStyleable: class {
  var style_shadowColor: UIColor? { get set }
  var style_shadowRadius: CGFloat { get set }
  var style_shadowOffset: CGSize { get set }
}

public protocol InnerShadowStyleable: class {
  var style_innerShadowColor: UIColor? { get set }
  var style_innerShadowRadius: CGFloat { get set }
  var style_innerShadowOffset: CGSize { get set }
}

public protocol EdgeInsetsStyleable: class {
  var style_edgeInsets: UIEdgeInsets { get set }
}

public protocol TextStyleable: class {
  var style_font: UIFont? { get set }
}