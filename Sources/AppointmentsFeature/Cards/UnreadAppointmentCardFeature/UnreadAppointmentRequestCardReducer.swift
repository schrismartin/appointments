import ComposableArchitecture

public struct UnreadAppointmentRequestCardReducer: Reducer {
  
  public init() {}
  
  public struct State: Equatable {
    var appointment: AppointmentsResponse.Appointment
  }
  
  public enum Action: Equatable {
    case delegate(Delegate)
    
    public enum Delegate {
      case acceptButtonPressed
      case declineButtonPressed
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
