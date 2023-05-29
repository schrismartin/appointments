import Foundation
import enum ComposableArchitecture.TaskResult

public enum Loadable<Success> {
  case ready
  case loading(Success?)
  case completed(TaskResult<Success>)
  
  @inlinable
  public func map<T>(_ transform: (Success) -> T) -> Loadable<T> {
    switch self {
    case .ready: return .ready
    case .loading(let stale):
      return .loading(stale.map(transform))
    case .completed(let result):
      return .completed(result.map(transform))
    }
  }
  
  public mutating func startLoading() {
    switch self {
    case .ready, .loading(nil), .completed(.failure):
      self = .loading(nil)
    case .loading(let stale?), .completed(.success(let stale)):
      self = .loading(stale)
    }
  }
  
  public var isComplete: Bool {
    if case .completed = self { return true }
    else { return false }
  }
  
  public var success: Success? {
    switch self {
    case .loading(let value?), .completed(.success(let value)):
      return value
    case .ready, .loading(nil), .completed(.failure):
      return nil
    }
  }
  
  public var failure: Error? {
    guard case .completed(.failure(let failure)) = self else { return nil }
    return failure
  }
}

extension Loadable: Equatable where Success: Equatable {}
extension Loadable: Hashable where Success: Hashable {}
