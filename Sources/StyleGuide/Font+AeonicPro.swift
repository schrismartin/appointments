import SwiftUI

extension Font {
  public static var aeonikHeadline: Font {
    Fonts.registerFonts()
    return .custom("AeonikProTRIAL-Bold", size: 12, relativeTo: .headline)
  }

  public static var aeonikTitle: Font {
    Fonts.registerFonts()
    return .custom("AeonikProTRIAL-Bold", size: 20, relativeTo: .title)
  }

  public static var aeonikTitle2: Font {
    Fonts.registerFonts()
    return .custom("AeonikProTRIAL-Regular", size: 18, relativeTo: .title)
  }

  public static var aeonikCaption: Font {
    Fonts.registerFonts()
    return .custom("AeonikProTRIAL-Regular", size: 11, relativeTo: .caption)
  }

  public static var aeonikBody: Font {
    Fonts.registerFonts()
    return .custom("AeonikProTRIAL-Regular", size: 14, relativeTo: .body)
  }

  public static var aeonikButton: Font {
    Fonts.registerFonts()
    return .custom("AeonikProTRIAL-Bold", size: 15, relativeTo: .headline)
  }
}

public enum Fonts {

  private static var didRegisterFonts = false

  public static func registerFonts() {
    guard !didRegisterFonts else { return }

    let fonts = [
      "AeonikProTRIAL-Regular",
      "AeonikProTRIAL-Bold",
    ]

    for font in fonts {
      guard
        let url = Bundle.module.url(forResource: font, withExtension: "otf"),
        let provider = CGDataProvider(url: url as CFURL),
        let font = CGFont(provider)
      else {
        fatalError("Could not initialize font \(font)")
      }

      var error: Unmanaged<CFError>?
      CTFontManagerRegisterGraphicsFont(font, &error)
    }

    didRegisterFonts = true
  }
}
