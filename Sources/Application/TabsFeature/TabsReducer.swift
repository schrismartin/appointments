import AppointmentsFeature
import ComposableArchitecture

public struct TabsReducer: Reducer {

  public init() {}

  public struct State: Equatable {
    var appointments: AppointmentsReducer.State
    var currentTab: Tab

    public init(appointments: AppointmentsReducer.State, currentTab: Tab) {
      self.appointments = appointments
      self.currentTab = currentTab
    }

    public enum Tab: Hashable {
      case rx, appointments, payments, performance
    }
  }

  public enum Action: Equatable {
    case appointments(AppointmentsReducer.Action)
    case tabChanged(State.Tab)
  }

  public var body: some ReducerOf<Self> {
    Scope(state: \State.appointments, action: /Action.appointments) {
      AppointmentsReducer()
    }

    Reduce { state, action in
      switch action {
      case .tabChanged(let tab):
        state.currentTab = tab
        return .none

      case .appointments:
        return .none
      }
    }
  }
}
