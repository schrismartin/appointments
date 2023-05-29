import Foundation

public struct Resource<Response: Codable> {
  internal var method: HTTPMethod
  internal var path: String
  internal var body: Data?
  
  internal var urlRequest: URLRequest {
    var request = URLRequest(url: URL(string: path)!)
    request.httpMethod = method.rawValue
    return request
  }
}

extension Resource {
  public static func `get`(_ path: String) -> Self {
    Resource(method: .get, path: path)
  }
  
  public static func post<Body: Codable>(_ path: String, body: Body) -> Self {
    // NB: This POST method exists to demonstrate the proposed API for dealing with POST requests.
    // However, since the assignment doesn't require that we POST anything, I've opted to leave this
    // blank.
    fatalError("POST is not implemented because it is not used.")
  }
}

enum HTTPMethod: String {
  case get = "GET"
}
