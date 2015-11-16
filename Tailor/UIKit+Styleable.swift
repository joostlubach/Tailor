import UIKit

extension UIView: BackgroundStyleable {
  public var opacity: CGFloat {
    get { return alpha }
    set { alpha = newValue }
  }
}

extension UIView: BorderStyleable {
  public var borderColor: UIColor? {
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

  public var borderWidth: CGFloat {
    get {
      return layer.borderWidth
    }
    set {
      layer.borderWidth = newValue
    }
  }

  public var cornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    }
    set {
      layer.cornerRadius = newValue
    }
  }
}

extension UIView: ShadowStyleable {
  public var shadowColor: UIColor? {
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

  public var shadowRadius: CGFloat {
    get {
      return layer.shadowRadius
    }
    set {
      layer.shadowRadius = newValue
    }
  }

  public var shadowOffset: CGSize {
    get {
      return layer.shadowOffset
    }
    set {
      layer.shadowOffset = newValue
    }
  }
}

extension UIView: ForegroundStyleable {
  public var foregroundColor: UIColor? {
    get {
      return tintColor
    }
    set {
      tintColor = newValue
    }
  }
}

extension UIButton {
  public override var foregroundColor: UIColor? {
    get {
      return super.foregroundColor
    }
    set {
      super.foregroundColor = newValue
      setTitleColor(newValue, forState: .Normal)
    }
  }
}

extension UILabel {
  public override var foregroundColor: UIColor? {
    get {
      return super.foregroundColor
    }
    set {
      super.foregroundColor = newValue
      textColor = newValue
    }
  }
}

extension UITextField {
  public override var foregroundColor: UIColor? {
    get {
      return super.foregroundColor
    }
    set {
      super.foregroundColor = newValue
      textColor = newValue
    }
  }
}

extension UITextView {
  public override var foregroundColor: UIColor? {
    get {
      return super.foregroundColor
    }
    set {
      super.foregroundColor = newValue
      textColor = newValue
    }
  }
}

extension UILabel: TextStyleable {
  public var fontFamily: String? {
    get {
      return font?.familyName
    }
    set {
      if let name = newValue {
        font = UIFont(name: name, size: fontSize)
      } else {
        font = nil
      }
    }
  }

  public var fontSize: CGFloat {
    get {
      return font?.pointSize ?? Defaults.fontSize
    }
    set {
      if let fontFamilyName = fontFamily {
        self.font = UIFont(name: fontFamilyName, size: newValue)
      } else {
        self.font = UIFont.systemFontOfSize(newValue)
      }
    }
  }
}