import Foundation

extension JSONDecoder {
  /// The default JSON Decoder.
  ///
  /// This is an opinionated decoder that matches the API that we're working with. It assumes
  /// that all methods within this API have the following properties:
  /// - Dates are formatted using ISO0601
  public static let `default`: JSONDecoder = {
    var decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .custom { decoder in
      let container = try decoder.singleValueContainer()
      let dateString = try container.decode(String.self)
      
      guard let date = ISO8601DateFormatter.default.date(from: dateString) else {
        throw DecodingError.dataCorruptedError(
          in: container,
          debugDescription: "Cannot decode date string \(dateString)"
        )
      }
      
      return date
    }
    
    return decoder
  }()
}
