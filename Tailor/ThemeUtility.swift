import Foundation

class ThemeUtility {

  class func getAllViewsRecursively(root: UIView) -> [UIView] {
    var result: [UIView] = []
    var todo: [UIView]   = [root]

    while todo.count > 0 {
      let current = todo.removeAtIndex(0)
      result.append(current)

      if current === root || current is RootView || current is ContainerView || current is UIScrollView {
        todo += current.subviews as! [UIView]
      }
    }

    return result
  }

}     