import ComposableArchitecture

public struct UnreadConversationCardReducer: Reducer {
  
  public init() {}
  
  public struct State: Equatable {
    var appointment: AppointmentsResponse.Appointment
  }
  
  public enum Action: Equatable {}
  
  public var body: some ReducerOf<Self> {
    EmptyReducer()
  }
}
