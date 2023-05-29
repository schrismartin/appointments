import Foundation

extension JSONEncoder {
  /// The default JSON Encoder.
  ///
  /// This is an opinionated encoder that matches the API that we're working with. It assumes
  /// that all methods within this API have the following properties:
  /// - Dates are formatted using ISO0601
  public static let `default`: JSONEncoder = {
    var encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .custom { date, encoder in
      var container = encoder.singleValueContainer()
      let dateString = ISO8601DateFormatter.default.string(from: date)
      try container.encode(dateString)
    }
    return encoder
  }()
}
