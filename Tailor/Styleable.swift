import UIKit

// This file contains the protocols Styleable objects can conform to.

public protocol BackgroundStyleable: class {
  var opacity: CGFloat { get set }
  var backgroundColor: UIColor? { get set }
}

public protocol ForegroundStyleable: class {
  var foregroundColor: UIColor? { get set }
}

public protocol BorderStyleable: class {
  var borderColor: UIColor? { get set }
  var borderWidth: CGFloat { get set }
  var cornerRadius: CGFloat { get set }
}

public protocol ShadowStyleable: class {
  var shadowColor: UIColor? { get set }
  var shadowRadius: CGFloat { get set }
  var shadowOffset: CGSize { get set }
}

public protocol TextStyleable: class {
  var fontFamily: String? { get set }
  var fontSize: CGFloat { get set }
}