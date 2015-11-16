/// A wrapper around any Styleable, which allows setting style properties directly. If the Styleable instance conforms to
/// any of the Styleable protocols, corresponding properties will be set. If not, these properties are ignored.
public class StyleableWrapper {

  init(styleable: AnyObject) {
    self.styleable = styleable
  }

  let styleable: AnyObject

}

extension StyleableWrapper: BackgroundStyleable {

  public var opacity: CGFloat {
    get {
      if let backgroundStyleable = styleable as? BackgroundStyleable {
        return backgroundStyleable.opacity
      } else {
        return 0
      }
    }
    set {
      if let backgroundStyleable = styleable as? BackgroundStyleable {
        backgroundStyleable.opacity = newValue
      }
    }
  }

  public var backgroundColor: UIColor? {
    get {
      if let backgroundStyleable = styleable as? BackgroundStyleable {
        return backgroundStyleable.backgroundColor
      } else {
        return nil
      }
    }
    set {
      if let backgroundStyleable = styleable as? BackgroundStyleable {
        backgroundStyleable.backgroundColor = newValue
      }
    }
  }

}

extension StyleableWrapper: ForegroundStyleable {

  public var foregroundColor: UIColor? {
    get {
      if let foregroundStyleable = styleable as? ForegroundStyleable {
        return foregroundStyleable.foregroundColor
      } else {
        return nil
      }
    }
    set {
      if let foregroundStyleable = styleable as? ForegroundStyleable {
        foregroundStyleable.foregroundColor = newValue
      }
    }
  }

}


extension StyleableWrapper: BorderStyleable {

  public var borderColor: UIColor? {
    get {
      if let borderStyleable = styleable as? BorderStyleable {
        return borderStyleable.borderColor
      } else {
        return nil
      }
    }
    set {
      if let borderStyleable = styleable as? BorderStyleable {
        borderStyleable.borderColor = newValue
      }
    }
  }

  public var borderWidth: CGFloat {
    get {
      if let borderStyleable = styleable as? BorderStyleable {
        return borderStyleable.borderWidth
      } else {
        return 0
      }
    }
    set {
      if let borderStyleable = styleable as? BorderStyleable {
        borderStyleable.borderWidth = newValue
      }
    }
  }

  public var cornerRadius: CGFloat {
    get {
      if let borderStyleable = styleable as? BorderStyleable {
        return borderStyleable.cornerRadius
      } else {
        return 0
      }
    }
    set {
      if let borderStyleable = styleable as? BorderStyleable {
        borderStyleable.cornerRadius = newValue
      }
    }
  }
  
}

extension StyleableWrapper: ShadowStyleable {

  public var shadowColor: UIColor? {
    get {
      if let shadowStyleable = styleable as? ShadowStyleable {
        return shadowStyleable.shadowColor
      } else {
        return nil
      }
    }
    set {
      if let shadowStyleable = styleable as? ShadowStyleable {
        shadowStyleable.shadowColor = newValue
      }
    }
  }

  public var shadowRadius: CGFloat {
    get {
      if let shadowStyleable = styleable as? ShadowStyleable {
        return shadowStyleable.shadowRadius
      } else {
        return 0
      }
    }
    set {
      if let shadowStyleable = styleable as? ShadowStyleable {
        shadowStyleable.shadowRadius = newValue
      }
    }
  }

  public var shadowOffset: CGSize {
    get {
      if let shadowStyleable = styleable as? ShadowStyleable {
        return shadowStyleable.shadowOffset
      } else {
        return CGSizeZero
      }
    }
    set {
      if let shadowStyleable = styleable as? ShadowStyleable {
        shadowStyleable.shadowOffset = newValue
      }
    }
  }

}

extension StyleableWrapper: TextStyleable {

  public var fontFamily: String? {
    get {
      if let textStyleable = styleable as? TextStyleable {
        return textStyleable.fontFamily
      } else {
        return nil
      }
    }
    set {
      if let textStyleable = styleable as? TextStyleable {
        textStyleable.fontFamily = newValue
      }
    }
  }

  public var fontSize: CGFloat {
    get {
      if let textStyleable = styleable as? TextStyleable {
        return textStyleable.fontSize
      } else {
        return 0
      }
    }
    set {
      if let textStyleable = styleable as? TextStyleable {
        textStyleable.fontSize = newValue
      }
    }
  }

}