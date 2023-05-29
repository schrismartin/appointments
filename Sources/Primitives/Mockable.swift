import Foundation

public protocol Mockable {
  /// A value with a generic mock values that can be used for tests, placeholders, etc.
  static var mock: Self { get }
}

extension Array: Mockable where Element: Mockable {
  public static var mock: [Element] {
    (0..<10).map { _ in .mock }
  }
}

extension Date: Mockable {
  public static var mock: Date {
    // Friday May 26, 2023
    return Date(timeIntervalSinceReferenceDate: 706_821_885)
  }
}
