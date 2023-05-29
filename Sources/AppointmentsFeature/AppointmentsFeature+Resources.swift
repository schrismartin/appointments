import Foundation
import APIClient

extension Resource<AppointmentsResponse> {
  /// API Request fetching a list of appointments.
  public static let appointments: Self = .get("/appointment")
}
