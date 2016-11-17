import Foundation

class ThemeUtility {

  class func getAllViewsRecursively(_ root: UIView) -> [UIView] {
    var result: [UIView] = []
    var todo: [UIView]   = [root]

    while todo.count > 0 {
      let current = todo.remove(at: 0)

      // Skip themed subviews as they (should) have their own theme.
      if current !== root && current is ThemedView {
        continue
      }

      if !current.skipStyling {
        result.append(current)
      }

      if current === root || current.isContainerView {
        todo += current.subviews 
      }
    }

    return result
  }

}     
