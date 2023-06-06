import SwiftUI

extension Color {
  public static let pawpBrilliantBlue = Color(red: 42 / 255, green: 114 / 255, blue: 212 / 255)
  public static let pawpLiveGreen = Color(red: 27 / 255, green: 178 / 255, blue: 115 / 255)
  public static let avatarRed = Color(red: 243 / 255, green: 116 / 255, blue: 91 / 255)

  public static var inactiveForeground = Color.secondary.opacity(0.48 * 1.5)
  public static var inactiveBackground = Color.secondary.opacity(0.16 * 1.5)
}
