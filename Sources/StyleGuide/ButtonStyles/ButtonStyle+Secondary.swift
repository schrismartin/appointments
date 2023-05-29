import SwiftUI

public struct SecondaryButtonStyle: ButtonStyle {
  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.aeonikButton)
      .foregroundColor(.inactiveForeground)
      .padding(.horizontal, 34)
      .padding(.vertical, 9)
      .background(
        Color.inactiveBackground,
        in: RoundedRectangle(cornerRadius: 40, style: .continuous)
      )
      .opacity(configuration.isPressed ? 0.3 : 1)
  }
}

extension ButtonStyle where Self == SecondaryButtonStyle {
  
  public static var secondary: SecondaryButtonStyle {
    SecondaryButtonStyle()
  }
}
