import ComposableArchitecture

public struct AppointmentReducer: Reducer {
  public enum State: Equatable, Identifiable {
    case unreadRequest(UnreadAppointmentRequestCardReducer.State)
    case startingSoon(StartingSoonCardReducer.State)
    case unreadConversation(UnreadConversationCardReducer.State)
    case ended(EndedCardReducer.State)
    
    public var id: AppointmentsResponse.Appointment.ID {
      switch self {
      case .unreadRequest(let state): return state.appointment.id
      case .startingSoon(let state): return state.appointment.id
      case .unreadConversation(let state): return state.appointment.id
      case .ended(let state): return state.appointment.id
      }
    }
    
    init(appointment: AppointmentsResponse.Appointment) {
      switch appointment.status {
      case .requested:
        self = .unreadRequest(UnreadAppointmentRequestCardReducer.State(appointment: appointment))
      case .initiated:
        self = .startingSoon(StartingSoonCardReducer.State(appointment: appointment))
      case .active:
        self = .unreadConversation(UnreadConversationCardReducer.State(appointment: appointment))
      case .completed:
        self = .ended(EndedCardReducer.State(appointment: appointment))
      case .unhandled:
        fatalError()
      }
    }
  }
  
  public enum Action: Equatable {
    case unreadRequest(UnreadAppointmentRequestCardReducer.Action)
    case startingSoon(StartingSoonCardReducer.Action)
    case unreadConversation(UnreadConversationCardReducer.Action)
    case ended(EndedCardReducer.Action)
  }
  
  public var body: some ReducerOf<Self> {
    Scope(state: /State.unreadRequest, action: /Action.unreadRequest) {
      UnreadAppointmentRequestCardReducer()
    }
    Scope(state: /State.startingSoon, action: /Action.startingSoon) {
      StartingSoonCardReducer()
    }
    Scope(state: /State.unreadConversation, action: /Action.unreadConversation) {
      UnreadConversationCardReducer()
    }
    Scope(state: /State.ended, action: /Action.ended) {
      EndedCardReducer()
    }
  }
}

