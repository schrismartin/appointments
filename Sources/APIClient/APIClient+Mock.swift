import Foundation

extension APIClient {
  
  /// An APIClient that always fails with a 404 Not Found error.
  public static var notFound: APIClient {
    APIClient { request in throw HTTPError(statusCode: 404) }
  }
  
  /// Return a new APIClient, stubbing the provided resource with the provided response.
  /// - Parameters:
  ///   - resource: Resource to stub
  ///   - response: Stubbed response
  /// - Returns: an APIClient stubbing the old response
  public func stubbing<Response: Encodable>(
    _ resource: Resource<Response>,
    with response: Response
  ) -> APIClient {
    return APIClient { request in
      guard
        request.url?.path() == resource.urlRequest.url?.path(),
        resource.method.rawValue == request.httpMethod
      else {
        // If our request doesn't match our resource, fall back to the default implementation.
        return try await _fetch(request)
      }
      
      return (
        try JSONEncoder.default.encode(response),
        HTTPURLResponse(
          url: request.url!,
          statusCode: 200,
          httpVersion: "HTTP/1.1",
          headerFields: [:]
        )!
      )
    }
  }
}

