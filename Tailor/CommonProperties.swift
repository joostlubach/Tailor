/**
  This file contains commonly used properties, and their application to commonly used UIKit views.
**/

// MARK: -
// MARK: Foreground color

public let foregroundColor: Property<UIColor> = {
  let foregroundColor = Property<UIColor>("foreground-color")

  foregroundColor.application(UIView.self) { view, color in
    view.tintColor = color
    view.tintAdjustmentMode = .Normal
  }
  foregroundColor.application(UILabel.self) { label, color in
    label.textColor = color
  }
  foregroundColor.application(UITextField.self) { field, color in
    field.textColor = color
  }
  foregroundColor.application(UITextView.self) { view, color in
    view.textColor = color
  }
  foregroundColor.application(UIButton.self) { button, color in
    button.setTitleColor(color, forState: .Normal)
    return ()
  }

  return foregroundColor
}()

public let selectedForegroundColor: Property<UIColor> = {
  let selectedForegroundColor = Property<UIColor>("selected-foreground-color")

  return selectedForegroundColor
}()

// MARK: Placeholder color

public let placeholderColor: Property<UIColor> = {
  let placeholderColor = Property<UIColor>("placeholder-color")

  placeholderColor.application(UITextField.self) { field, color in
    if let text = field.placeholder {
      field.attributedPlaceholder = NSAttributedString(
        string: text,
        attributes: [NSForegroundColorAttributeName: color]
      )
    }
  }

  return placeholderColor
}()

// MARK: -
// MARK: Background color

public let backgroundColor: Property<UIColor> = {
  let backgroundColor = Property<UIColor>("background-color")

  backgroundColor.application { view, color in
    view.backgroundColor = color
    view.opaque = CGColorGetAlpha(color.CGColor) == 1.0
  }
  backgroundColor.application(UISearchBar.self) { bar, color in
    bar.barTintColor = color
  }

  return backgroundColor
}()

// MARK: Selected background color

public let selectedBackgroundColor: Property<UIColor> = {
  let selectedBackgroundColor = Property<UIColor>("selected-background-color")

  selectedBackgroundColor.application(UITableViewCell.self) { cell, color in
    let bgView = UIView()
    bgView.backgroundColor = color
    cell.selectedBackgroundView = bgView
  }

  return selectedBackgroundColor
}()

public let opacity: Property<CGFloat> = {
  let opacity = Property<CGFloat>("opacity")

  opacity.application(UIView.self) { view, opacity in
    view.alpha = opacity
  }

  return opacity
}()


// MARK: -
// MARK: Border color

public let borderColor: Property<UIColor> = {
  let borderColor = Property<UIColor>("border-color")

  borderColor.application(UIView.self) { view, color in
    view.layer.borderColor = color.CGColor
  }

  return borderColor
}()

// MARK: Border width

public let borderWidth: Property<CGFloat> = {
  let borderWidth = Property<CGFloat>("border-width")

  borderWidth.application(UIView.self) { view, width in
    view.layer.borderWidth = width
  }

  return borderWidth
}()

// MARK: Corner radius

public let cornerRadius: Property<CGFloat> = {
  let cornerRadius = Property<CGFloat>("corner-radius")

  cornerRadius.application(UIView.self) { view, radius in
    view.layer.cornerRadius = radius
  }

  return cornerRadius
}()

// MARK: -
// MARK: Font

public let font: Property<UIFont> = {
  let font = Property<UIFont>("font")

  font.application(UILabel.self) { label, font in
    label.font = font
  }
  font.application(UITextField.self) { field, font in
    field.font = font
  }
  font.application(UITextView.self) { view, font in
    view.font = font
  }
  font.application(UIButton.self) { button, font in
    button.titleLabel?.font = font
    return ()
  }

  return font
}()