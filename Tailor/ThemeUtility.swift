import Foundation

public class ThemeUtility {

<<<<<<< Updated upstream
  /// Recursively gets all views from a given root view. This uses the signalling protocols `ThemeContainerView` and
  /// `UnthemedView` to determine the exact view hierarchy for a certain root view.
  public class func getAllViewsRecursively(root: UIView) -> [UIView] {
    var result: [UIView] = [root]
    var todo: [UIView]   = root.subviews
=======
  class func getAllViewsRecursively(_ root: UIView) -> [UIView] {
    var result: [UIView] = []
    var todo: [UIView]   = [root]
>>>>>>> Stashed changes

    while todo.count > 0 {
      let current = todo.remove(at: 0)

      // Skip any theme that does not want to participate in the view, i.e. is 'unthemed'.
      if current is UnthemedView {
        continue
      }

      result.append(current)

      // If this is a theme container view, include its subviews as well.
      if current is ThemeContainerView {
        todo += current.subviews 
      }
    }

    return result
  }

}     
