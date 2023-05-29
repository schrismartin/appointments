import SwiftUI

public struct PrimaryButtonStyle: ButtonStyle {
  
  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.aeonikButton)
      .foregroundColor(.white)
      .padding(.horizontal, 34)
      .padding(.vertical, 9)
      .background(Color.accentColor, in: RoundedRectangle(cornerRadius: 40, style: .continuous))
      .opacity(configuration.isPressed ? 0.3 : 1)
  }
}

extension ButtonStyle where Self == PrimaryButtonStyle {
  public static var primary: PrimaryButtonStyle {
    PrimaryButtonStyle()
  }
}
