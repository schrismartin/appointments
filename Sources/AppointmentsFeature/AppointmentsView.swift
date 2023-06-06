import APIClient
import ComposableArchitecture
import Primitives
import SwiftUI

public struct AppointmentsView: View {
  let store: StoreOf<AppointmentsReducer>

  public init(store: StoreOf<AppointmentsReducer>) {
    self.store = store
  }

  struct ViewState: Equatable {
    var cardIDs: [AppointmentsResponse.Appointment.ID]

    init(state: AppointmentsReducer.State) {
      self.cardIDs = state.cardStates.map(\.id)
    }
  }

  public var body: some View {
    WithViewStore(store, observe: ViewState.init) { viewStore in
      // NB: This uses ScrollView + LazyVStack due to a bug where deletions on a non-final cell
      // causes the last cell to be removed followed by an update to all cells.
      ScrollView {
        LazyVStack {
          ForEachStore(
            store.scope(
              state: \.cardStates,
              action: AppointmentsReducer.Action.appointment
            ),
            content: AppointmentView.init(store:)
          )
          .padding(.horizontal)
        }
        .padding(.vertical)
      }
      .listStyle(.plain)
      .toolbar {
        ToolbarItem(placement: .principal) {
          HStack {
            Text("Appointments")
              .font(.aeonikTitle)
            Spacer()
          }
          .frame(maxWidth: .infinity)
        }

        ToolbarItem(placement: .navigationBarLeading) {
          Button {
            viewStore.send(.view(.openTabButtonPressed))
          } label: {
            Label {
              Text("Open Tab")
            } icon: {
              Image.iconOpenTab
                .resizable()
                .frame(width: 14, height: 14)
            }
          }
        }
      }
      .navigationBarTitleDisplayMode(.inline)
      .refreshable {
        await viewStore.send(.view(.onRefresh)).finish()
      }
      .task {
        await viewStore.send(.view(.onTask)).finish()
      }
    }
  }
}

#if DEBUG

struct AppointmentsView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      AppointmentsView(
        store: Store(initialState: .init()) {
          AppointmentsReducer()
        } withDependencies: { dependencies in
          dependencies.apiClient = .liveValue
        }
      )
    }
  }
}

#endif
