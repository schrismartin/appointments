import Foundation

public protocol FallbackRawRepresentable: RawRepresentable {
  static var unhandled: Self { get }
}

extension FallbackRawRepresentable where RawValue: Decodable {
  public init(
    from decoder: Decoder
  ) throws {
    let container = try decoder.singleValueContainer()
    let value = try container.decode(RawValue.self)
    self = Self(rawValue: value) ?? Self.unhandled
  }
}
