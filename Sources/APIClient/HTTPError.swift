import Foundation

public struct HTTPError: Error, Equatable {
  public var statusCode: Int

  public init(statusCode: Int) {
    self.statusCode = statusCode
  }

  public static let notFound = HTTPError(statusCode: 404)
}
