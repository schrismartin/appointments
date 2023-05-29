import APIClient
import ComposableArchitecture
import Primitives

public struct AppointmentsReducer: Reducer {
  @Dependency(\.apiClient) var apiClient
  @Dependency(\.continuousClock) var clock

  public init() {}

  public struct State: Equatable {
    var cardStates: IdentifiedArrayOf<AppointmentReducer.State>

    public init() {
      self.cardStates = []
    }
  }

  public enum Action: Equatable {
    case didReceiveAppointments(TaskResult<AppointmentsResponse>)
    case view(ViewAction)

    case appointment(AppointmentsResponse.Appointment.ID, AppointmentReducer.Action)

    public enum ViewAction: Equatable {
      case onTask
      case onRefresh
      case openTabButtonPressed
    }
  }

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .view(let action):
        switch action {
        case .onTask:
          return .run { send in
            let result = await TaskResult {
              try await apiClient.fetch(.appointments)
            }

            await send(.didReceiveAppointments(result))
          }

        case .onRefresh:
          return .run { send in
            try await clock.sleep(for: .seconds(1))

            let result = await TaskResult {
              try await apiClient.fetch(.appointments)
            }

            await send(.didReceiveAppointments(result), animation: .default)
          }

        case .openTabButtonPressed:
          return .none
        }

      case .didReceiveAppointments(.success(let response)):
        state.cardStates = IdentifiedArray(
          uniqueElements: response.appointments
            .map(AppointmentReducer.State.init(appointment:))
        )
        return .none

      case .didReceiveAppointments(.failure):
        return .none

      case .appointment(let id, let action):
        switch action {
        case .unreadRequest(.delegate(.acceptButtonPressed)),
          .unreadRequest(.delegate(.declineButtonPressed)):
          state.cardStates.remove(id: id)
          return .none

        case .unreadConversation, .startingSoon, .ended:
          return .none
        }
      }
    }
    .forEach(\.cardStates, action: /Action.appointment) {
      AppointmentReducer()
    }
  }
}
