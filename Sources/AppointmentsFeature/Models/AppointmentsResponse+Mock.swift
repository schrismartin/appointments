import Dependencies
import Foundation
import Primitives

extension AppointmentsResponse: Mockable {
  public static var mock: AppointmentsResponse {
    AppointmentsResponse(
      appointments: [
        AppointmentsResponse.Appointment(
          id: UUID(0).uuidString,
          professional: .mock,
          user: .mock,
          startTime: .mock + 1 * 60,
          endTime: .mock + 10000,
          length: 10000,
          topic: "Flea/Tick",
          status: .active,
          requestedAt: .mock + 5 * 60,
          lastMessage:
            "What do you think about trying one other product that might be a little different for thier skin",
          lastMessageAt: .mock + 9
        ),
        AppointmentsResponse.Appointment(
          id: UUID(1).uuidString,
          professional: .mock,
          user: .mock,
          startTime: .mock + 2 * 60,
          endTime: .mock + 10000,
          length: 10000,
          topic: "Flea/Tick",
          status: .completed,
          requestedAt: .mock + 6 * 60,
          lastMessage:
            "What do you think about trying one other product that might be a little different for thier skin",
          lastMessageAt: .mock + 10 * 60
        ),
        AppointmentsResponse.Appointment(
          id: UUID(2).uuidString,
          professional: .mock,
          user: .mock,
          startTime: .mock + 3 * 60,
          endTime: .mock + 10000,
          length: 10000,
          topic: "Flea/Tick",
          status: .initiated,
          requestedAt: .mock + 7 * 60,
          lastMessage:
            "What do you think about trying one other product that might be a little different for thier skin",
          lastMessageAt: .mock + 11 * 60
        ),
        AppointmentsResponse.Appointment(
          id: UUID(3).uuidString,
          professional: .mock,
          user: .mock,
          startTime: .mock + 4 * 60,
          endTime: .mock + 10000,
          length: 10000,
          topic: "Flea/Tick",
          status: .requested,
          requestedAt: .mock + 8 * 60,
          lastMessage:
            "What do you think about trying one other product that might be a little different for thier skin",
          lastMessageAt: .mock + 12 * 60
        ),
      ]
    )
  }

  func configured(_ transform: (inout Self) -> Void) -> Self {
    var mutableSelf = self
    transform(&mutableSelf)
    return mutableSelf
  }
}

extension AppointmentsResponse.Appointment: Mockable {
  public static var mock: AppointmentsResponse.Appointment {
    return AppointmentsResponse.Appointment(
      id: UUID(0).uuidString,
      professional: .mock,
      user: .mock,
      startTime: .mock,
      endTime: .mock + 10000,
      length: 10000,
      topic: "Flea/Tick",
      status: .requested,
      requestedAt: .mock,
      lastMessage: "What do you think about trying one other product that might be a little different for thier skin",
      lastMessageAt: .mock
    )
  }
}

extension AppointmentsResponse.Appointment.Professional: Mockable {
  public static var mock: AppointmentsResponse.Appointment.Professional {
    AppointmentsResponse.Appointment.Professional(
      id: 256,
      firstName: "Jane",
      lastName: "Doe",
      jobTitle: .dvm
    )
  }
}

extension AppointmentsResponse.Appointment.User: Mockable {
  public static var mock: AppointmentsResponse.Appointment.User {
    AppointmentsResponse.Appointment.User(
      id: 512,
      firstName: "John",
      lastName: "Doe"
    )
  }
}
