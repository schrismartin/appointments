import ComposableArchitecture

public struct StartingSoonCardReducer: Reducer {

  public init() {}

  public struct State: Equatable {
    var appointment: AppointmentsResponse.Appointment
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
