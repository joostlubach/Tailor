/// A wrapper around any Styleable, which allows setting style properties directly. If the Styleable instance conforms to
/// any of the Styleable protocols, corresponding properties will be set. If not, these properties are ignored.
public class StyleableWrapper {

  init(styleable: AnyObject) {
    self.styleable = styleable
  }

  public let styleable: AnyObject

}

// MARK: BackgroundStyleable
extension StyleableWrapper {

  private var backgroundStyleable: BackgroundStyleable? {
    return styleable as? BackgroundStyleable
  }

  /// The opacity of the styled object, if it is BackgroundStyleable.
  public var opacity: CGFloat {
    get { return backgroundStyleable?.style_opacity ?? 1 }
    set { backgroundStyleable?.style_opacity = newValue }
  }

  /// The background color of the styled object, if it is BackgroundStyleable.
  public var backgroundColor: UIColor? {
    get { return backgroundStyleable?.style_backgroundColor }
    set { backgroundStyleable?.style_backgroundColor = newValue }
  }

}

// MARK: ForegroundStyleable
extension StyleableWrapper {

  private var foregroundStyleable: ForegroundStyleable? {
    return styleable as? ForegroundStyleable
  }

  /// The foreground color of the styled object, if it is ForegroundStyleable.
  public var foregroundColor: UIColor? {
    get { return foregroundStyleable?.style_foregroundColor }
    set { foregroundStyleable?.style_foregroundColor = newValue }
  }

}


// MARK: BorderStyleable
extension StyleableWrapper {

  private var borderStyleable: BorderStyleable? {
    return styleable as? BorderStyleable
  }

  /// The border color of the styled object, if it is BorderStyleable.
  public var borderColor: UIColor? {
    get { return borderStyleable?.style_borderColor }
    set { borderStyleable?.style_borderColor = newValue }
  }

  /// The border width of the styled object, if it is BorderStyleable.
  public var borderWidth: CGFloat {
    get { return borderStyleable?.style_borderWidth ?? 0 }
    set { borderStyleable?.style_borderWidth = newValue }
  }

}

// MARK: CornerStyleable
extension StyleableWrapper {

  private var cornerStyleable: CornerStyleable? {
    return styleable as? CornerStyleable
  }

  /// The corner radius of the styled object, if it is CornerStyleable.
  public var cornerRadius: CGFloat {
    get { return cornerStyleable?.style_cornerRadius ?? 0 }
    set { cornerStyleable?.style_cornerRadius = newValue }
  }
  
}

// MARK: ShadowStyleable
extension StyleableWrapper {

  private var shadowStyleable: ShadowStyleable? {
    return styleable as? ShadowStyleable
  }

  /// The shadow color of the styled object, if it is ShadowStyleable.
  public var shadowColor: UIColor? {
    get { return shadowStyleable?.style_shadowColor }
    set { shadowStyleable?.style_shadowColor = newValue }
  }

  /// The shadow color of the styled object, if it is ShadowStyleable.
  public var shadowRadius: CGFloat {
    get { return shadowStyleable?.style_shadowRadius ?? 0 }
    set { shadowStyleable?.style_shadowRadius = newValue }
  }

  /// The shadow offset of the styled object, if it is ShadowStyleable.
  public var shadowOffset: CGSize {
    get { return shadowStyleable?.style_shadowOffset ?? CGSizeZero }
    set { shadowStyleable?.style_shadowOffset = newValue }
  }

}

// MARK: InnerShadowStyleable
extension StyleableWrapper {

  private var innerShadowStyleable: InnerShadowStyleable? {
    return styleable as? InnerShadowStyleable
  }

  /// The inner shadow color of the styled object, if it is ShadowStyleable.
  public var innerShadowColor: UIColor? {
    get { return innerShadowStyleable?.style_innerShadowColor }
    set { innerShadowStyleable?.style_innerShadowColor = newValue }
  }

  /// The inner shadow color of the styled object, if it is ShadowStyleable.
  public var innerShadowRadius: CGFloat {
    get { return innerShadowStyleable?.style_innerShadowRadius ?? 0 }
    set { innerShadowStyleable?.style_innerShadowRadius = newValue }
  }

  /// The inner shadow offset of the styled object, if it is ShadowStyleable.
  public var innerShadowOffset: CGSize {
    get { return innerShadowStyleable?.style_innerShadowOffset ?? CGSizeZero }
    set { innerShadowStyleable?.style_innerShadowOffset = newValue }
  }

}

// MARK: EdgeInsetsStyleable
extension StyleableWrapper {

  private var edgeInsetsStyleable: EdgeInsetsStyleable? {
    return styleable as? EdgeInsetsStyleable
  }

  /// The edge insets of the styled object, if it is EdgeInsetsStyleable.
  public var edgeInsets: UIEdgeInsets {
    get { return edgeInsetsStyleable?.style_edgeInsets ?? UIEdgeInsetsZero }
    set { edgeInsetsStyleable?.style_edgeInsets = newValue }
  }

}

// MARK: TextStyleable
extension StyleableWrapper {

  private var textStyleable: TextStyleable? {
    return styleable as? TextStyleable
  }

  /// The font of the styled object, if it is TextStyleable.
  public var font: UIFont? {
    get { return textStyleable?.style_font }
    set { textStyleable?.style_font = newValue }
  }

}