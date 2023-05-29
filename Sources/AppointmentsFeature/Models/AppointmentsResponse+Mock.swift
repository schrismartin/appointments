import Dependencies
import Foundation
import Primitives

extension AppointmentsResponse: Mockable {
  public static var mock: AppointmentsResponse {
    AppointmentsResponse(appointments: .mock)
  }
}

extension AppointmentsResponse.Appointment: Mockable {
  public static var mock: AppointmentsResponse.Appointment {
    @Dependency(\.uuid) var uuid: UUIDGenerator
    return AppointmentsResponse.Appointment(
      id: uuid().uuidString,
      professional: .mock,
      user: .mock,
      startTime: .mock,
      endTime: .mock + 10000,
      length: 10000,
      topic: "Flea/Tick",
      status: .initiated,
      requestedAt: .mock,
      lastMessage: "What do you think about trying one other product that might be a little different for thier skin",
      lastMessageAt: .mock
    )
  }
}

extension AppointmentsResponse.Appointment.Professional: Mockable {
  public static var mock: AppointmentsResponse.Appointment.Professional {
    @Dependency(\.withRandomNumberGenerator) var generator: WithRandomNumberGenerator
    return generator { generator in
      AppointmentsResponse.Appointment.Professional(
        id: Int.random(in: 1000..<9999, using: &generator),
        firstName: "Jane",
        lastName: "Doe",
        jobTitle: .dvm
      )
    }
  }
}

extension AppointmentsResponse.Appointment.User: Mockable {
  public static var mock: AppointmentsResponse.Appointment.User {
    @Dependency(\.withRandomNumberGenerator) var generator: WithRandomNumberGenerator
    return generator { generator in
      AppointmentsResponse.Appointment.User(
        id: Int.random(in: 1000..<9999, using: &generator),
        firstName: "John",
        lastName: "Doe"
      )
    }
  }
}
