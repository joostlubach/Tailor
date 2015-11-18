import UIKit

struct FontUtility {

  /// Obtains a list of all font names.
  static var allFontNames: [String] {
    var names = [String]()

    for familyName in UIFont.familyNames() {
      names += UIFont.fontNamesForFamilyName(familyName)
    }

    return names
  }

  /// Dumps a list of all font names to the console.
  static func dumpAllFontNames() {
    print(allFontNames)
  }

}