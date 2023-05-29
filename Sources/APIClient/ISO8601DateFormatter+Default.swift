import Foundation

extension ISO8601DateFormatter {
  static let `default`: ISO8601DateFormatter = {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [
      .withInternetDateTime,
      .withFractionalSeconds,
      .withTimeZone,
    ]
    return formatter
  }()
}
