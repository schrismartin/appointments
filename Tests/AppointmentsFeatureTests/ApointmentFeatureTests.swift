import APIClient
import ComposableArchitecture
import XCTest

@testable import AppointmentsFeature

@MainActor
final class AppointmentFeatureTests: XCTestCase {

  func testOnTask() async {
    let store = TestStore(
      initialState: AppointmentsReducer.State.init()
    ) {
      AppointmentsReducer()
    } withDependencies: { dependencies in
      dependencies.apiClient = .testValue
        .stubbing(.appointments, with: .mock)
    }

    await store.send(.view(.onTask))
    await store.receive(.didReceiveAppointments(.success(.mock))) { state in
      state.cardStates = [
        .ended(
          EndedCardReducer.State(
            appointment: AppointmentsResponse.mock.appointments[1]
          )
        ),
        .unreadRequest(
          UnreadAppointmentRequestCardReducer.State(
            appointment: AppointmentsResponse.mock.appointments[3]
          )
        ),
        .startingSoon(
          StartingSoonCardReducer.State(
            appointment: AppointmentsResponse.mock.appointments[2]
          )
        ),
        .unreadConversation(
          UnreadConversationCardReducer.State(
            appointment: AppointmentsResponse.mock.appointments[0]
          )
        ),
      ]
    }
  }

  func testOnTaskFailure() async {
    let store = TestStore(
      initialState: AppointmentsReducer.State.init()
    ) {
      AppointmentsReducer()
    } withDependencies: { dependencies in
      dependencies.apiClient = .notFound
    }

    await store.send(.view(.onTask))
    await store.receive(.didReceiveAppointments(.failure(HTTPError.notFound)))
  }

  func testOnAccept() async {
    let store = TestStore(
      initialState: AppointmentsReducer.State.init(response: .mock)
    ) {
      AppointmentsReducer()
    }

    await store.send(.appointment(UUID(3).uuidString, .unreadRequest(.delegate(.acceptButtonPressed)))) { state in
      state.cardStates.remove(at: 1)
    }
  }

  func testOnDecline() async {
    let store = TestStore(
      initialState: AppointmentsReducer.State.init(response: .mock)
    ) {
      AppointmentsReducer()
    }

    await store.send(.appointment(UUID(3).uuidString, .unreadRequest(.delegate(.declineButtonPressed)))) { state in
      state.cardStates.remove(at: 1)
    }
  }

  func testOnRefresh() async {

    let clock = TestClock()

    let store = TestStore(
      initialState: AppointmentsReducer.State.init(
        response: .mock.configured {
          $0.appointments.remove(at: 1)
        }
      )
    ) {
      AppointmentsReducer()
    } withDependencies: { dependencies in
      dependencies.apiClient = .testValue
        .stubbing(.appointments, with: .mock)
      dependencies.continuousClock = clock
    }

    await store.send(.view(.onRefresh))
    await clock.advance(by: .seconds(1))
    await store.receive(.didReceiveAppointments(.success(.mock))) { state in
      state.cardStates = [
        .ended(
          EndedCardReducer.State(
            appointment: AppointmentsResponse.mock.appointments[1]
          )
        ),
        .unreadRequest(
          UnreadAppointmentRequestCardReducer.State(
            appointment: AppointmentsResponse.mock.appointments[3]
          )
        ),
        .startingSoon(
          StartingSoonCardReducer.State(
            appointment: AppointmentsResponse.mock.appointments[2]
          )
        ),
        .unreadConversation(
          UnreadConversationCardReducer.State(
            appointment: AppointmentsResponse.mock.appointments[0]
          )
        ),
      ]
    }
  }
}
