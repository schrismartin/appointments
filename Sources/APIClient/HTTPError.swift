import Foundation

public struct HTTPError: Error {
  public var statusCode: Int
  
  public init(statusCode: Int) {
    self.statusCode = statusCode
  }
}
