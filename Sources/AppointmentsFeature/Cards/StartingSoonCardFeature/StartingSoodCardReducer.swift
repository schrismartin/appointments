import ComposableArchitecture

public struct StartingSoonCardReducer: Reducer {

  public init() {}

  public struct State: Equatable {
    var appointment: AppointmentsResponse.Appointment
    var formattedRelativeStartDate: String = ""

    init(appointment: AppointmentsResponse.Appointment) {
      @Dependency(\.date) var date: DateGenerator

      self.appointment = appointment
      self.formattedRelativeStartDate = appointment.startTime
        .formatted(.relative(presentation: .numeric, unitsStyle: .abbreviated))
    }
  }

  public enum Action: Equatable {
    case delegate(Delegate)

    public enum Delegate {
      case joinAppointmentButtonPressed
    }
  }

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .delegate:
        return .none
      }
    }
  }
}
