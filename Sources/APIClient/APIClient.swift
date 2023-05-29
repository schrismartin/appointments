import Foundation

public struct APIClient: Sendable {

  var _fetch: @Sendable (URLRequest) async throws -> (Data, URLResponse)

  public init(
    _fetch: @escaping @Sendable (URLRequest) async throws -> (Data, URLResponse)
  ) {
    self._fetch = _fetch
  }
}

extension APIClient {

  public func fetch<Response: Codable>(_ resource: Resource<Response>) async throws -> Response {
    let (data, response) = try await _fetch(resource.urlRequest)

    let httpResponse = response as! HTTPURLResponse

    guard (200..<300).contains(httpResponse.statusCode) else {
      throw HTTPError(statusCode: httpResponse.statusCode)
    }

    return try JSONDecoder.default.decode(Response.self, from: data)
  }
}
