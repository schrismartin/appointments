import Dependencies
import Foundation

extension APIClient: DependencyKey {
  public static var liveValue = APIClient(
    _fetch: { request in
      var request = request
      let productionBaseURL = URL(string: "https://interview.pawp.workers.dev")!
      
      var components = URLComponents(string: request.url!.absoluteString)!
      request.url = components.url(relativeTo: productionBaseURL)
      
      return try await URLSession.shared.data(for: request)
    }
  )
}

extension DependencyValues {
  
  /// A client used to make API requests
  public var apiClient: APIClient {
    get { self[APIClient.self] }
    set { self[APIClient.self] = newValue }
  }
}
