import UIKit

extension UIView: BackgroundStyleable {
  public var style_backgroundColor: UIColor? {
    get { return backgroundColor }
    set { backgroundColor = newValue }
  }

  public var style_opacity: CGFloat {
    get { return alpha }
    set { alpha = newValue }
  }
}

extension UIView: BorderStyleable {
  public var style_borderColor: UIColor? {
    get {
      if let color = layer.borderColor {
        return UIColor(CGColor: color)
      } else {
        return nil
      }
    }
    set {
      layer.borderColor = newValue?.CGColor
    }
  }

  public var style_borderWidth: CGFloat {
    get {
      return layer.borderWidth
    }
    set {
      layer.borderWidth = newValue
    }
  }
}

extension UIView: CornerStyleable {
  public var style_cornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    }
    set {
      layer.cornerRadius = newValue
    }
  }
}

extension UIView: ShadowStyleable {
  public var style_shadowColor: UIColor? {
    get {
      if let color = layer.shadowColor {
        return UIColor(CGColor: color).colorWithAlphaComponent(CGFloat(layer.shadowOpacity))
      } else {
        return nil
      }
    }
    set {
      layer.shadowColor = newValue?.colorWithAlphaComponent(1.0).CGColor
      layer.shadowOpacity = newValue != nil ? Float(CGColorGetAlpha(newValue!.CGColor)) : Float(0.0)
    }
  }

  public var style_shadowRadius: CGFloat {
    get {
      return layer.shadowRadius
    }
    set {
      layer.shadowRadius = newValue
    }
  }

  public var style_shadowOffset: CGSize {
    get {
      return layer.shadowOffset
    }
    set {
      layer.shadowOffset = newValue
    }
  }
}

extension UIView: ForegroundStyleable {
  public var style_foregroundColor: UIColor? {
    get {
      return tintColor
    }
    set {
      tintColor = newValue
    }
  }
}

extension UIButton {
  public override var style_foregroundColor: UIColor? {
    get {
      return super.style_foregroundColor
    }
    set {
      super.style_foregroundColor = newValue
      setTitleColor(newValue, forState: .Normal)
    }
  }
}

extension UIButton: EdgeInsetsStyleable {
  public var style_edgeInsets: UIEdgeInsets {
    get { return contentEdgeInsets }
    set { contentEdgeInsets = newValue }
  }
}

extension UILabel {
  public override var style_foregroundColor: UIColor? {
    get {
      return super.style_foregroundColor
    }
    set {
      super.style_foregroundColor = newValue
      textColor = newValue
    }
  }
}

extension UITextField {
  public override var style_foregroundColor: UIColor? {
    get {
      return super.style_foregroundColor
    }
    set {
      super.style_foregroundColor = newValue
      textColor = newValue
    }
  }
}

extension UITextView {
  public override var style_foregroundColor: UIColor? {
    get {
      return super.style_foregroundColor
    }
    set {
      super.style_foregroundColor = newValue
      textColor = newValue
    }
  }
}

extension UILabel: TextStyleable {
  public var style_font: UIFont? {
    get { return font }
    set { font = newValue }
  }
}

extension UIButton: TextStyleable {
  public var style_font: UIFont? {
    get { return titleLabel?.font }
    set { titleLabel?.font = newValue }
  }
}

extension UITextField: TextStyleable {
  public var style_font: UIFont? {
    get { return font }
    set { font = newValue }
  }
}