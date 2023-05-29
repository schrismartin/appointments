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

    init(state: AppointmentsReducer.State) {
    }
  }

  public var body: some View {
    WithViewStore(store, observe: ViewState.init) { viewStore in
      List {
        ForEachStore(
          store.scope(
            state: \.cardStates,
            action: AppointmentsReducer.Action.appointment
          ),
          content: AppointmentView.init(store:)
        )
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
