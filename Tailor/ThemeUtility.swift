import Foundation

class ThemeUtility {

  class func getAllViewsRecursively(root: UIView) -> [UIView] {
    var result: [UIView] = []
    var todo: [UIView]   = [root]

    while todo.count > 0 {
      let current = todo.removeAtIndex(0)
      result.append(current)

      if current === root {
        todo += current.subviews as! [UIView]
      }
      if let container = current as? ContainerView {
        todo += container.subviews as! [UIView]
      }
    }

    return result
  }

}