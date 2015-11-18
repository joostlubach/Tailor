import Foundation

/// Defines a certain style for any `Styleable` object. A `Style` is in essence nothing more than a block
/// that receives an instance of `StyleableWrapper`. For each styleable object that is styled with the style,
/// the styleable is wrapped and the handler is executed.
///
/// Example:
///
///     let roundedButtonStyle = Style { button in
///       button.backgroundColor = UIColor.redColor()
///       button.foregroundColor = UIColor.whiteColor()
///       button.cornerRadius = 4.0
///       button.font = UIFont.systemFontOfSize(16)
///     }
///
/// The `button` parameter passed to the block is of type `StyleableWrapper`, which contains all commonly
/// used style properties. As class `UIButton` conforms to protocols `BackgroundStyleable`, `ForegroundStyleable`,
/// `BorderStyleable` and `TextStyleable`, the wrapper will know what to do.
///
/// If you want to define a style for a specific class, use `StyleFor<T>`.
public class Style {

  /// Initializes the style.
  public init(handler: (StyleableWrapper) -> Void) {
    self.handler = handler
  }

  /// The style handler.
  let handler: (StyleableWrapper) -> Void

  /// Applies this style to the given styleable.
  public func applyTo(styleable: AnyObject) {
    let wrapper = StyleableWrapper(styleable: styleable)
    handler(wrapper)
  }

}

/// A style for a specific class. Contrary to `Style`, the handler now receives a direct instance of the given
/// class, rather than a generic wrapper. Use this to define a style for e.g. a custom view class.
///
/// Example:
///
///     let customButtonStyle = StyleFor<CustomButton> { button in
///       button.backgroundColor = UIColor.redColor()
///       button.setTitleColor(UIColor.whiteColor, forState: .Normal)
///       button.myCustomProperty = "my-custom-value"
///     }
///
/// In this example, the `button` parameter passed to the block is of type `CustomButton`.
public class StyleFor<T: AnyObject> {

  /// Initializes the style with a handler taking a specific instance of this class, but also a generic style wrapper,
  /// to apply generic styles.
  public init(handler: (T, StyleableWrapper) -> Void) {
    self.handler = handler
  }

  /// The handler.
  let handler: (T, StyleableWrapper) -> Void

  /// Applies the style to the given styleable.
  public func applyTo(styleable: T) {
    let wrapper = StyleableWrapper(styleable: styleable)
    handler(styleable, wrapper)
  }

}