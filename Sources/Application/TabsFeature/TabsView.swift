import AppointmentsFeature
import ComposableArchitecture
import SwiftUI

public struct TabsView: View {
  var store: StoreOf<TabsReducer>

  public init(store: StoreOf<TabsReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: \.currentTab) { viewStore in
      TabView(
        selection: viewStore.binding(
          get: { $0 },
          send: TabsReducer.Action.tabChanged
        )
      ) {
        NavigationStack {
          Text("Prescriptions")
        }
        .tag(TabsReducer.State.Tab.rx)
        .tabItem {
          Label {
            Text("Prescriptions")
          } icon: {
            Image.iconRx
              .tint(.pawpBrilliantBlue)
          }
          .labelStyle(.iconOnly)
        }

        NavigationStack {
          AppointmentsView(
            store: store.scope(
              state: \.appointments,
              action: TabsReducer.Action.appointments
            )
          )
        }
        .tag(TabsReducer.State.Tab.appointments)
        .tabItem {
          Label {
            Text("Appointments")
          } icon: {
            Image.iconCalendar
              .tint(.pawpBrilliantBlue)
          }
          .labelStyle(.iconOnly)
        }

        NavigationStack {
          Text("Payments")
        }
        .tag(TabsReducer.State.Tab.payments)
        .tabItem {
          Label {
            Text("Payments")
          } icon: {
            Image.iconPayments
              .tint(.pawpBrilliantBlue)
          }
          .labelStyle(.iconOnly)
        }

        NavigationStack {
          Text("Performance")
        }
        .tag(TabsReducer.State.Tab.performance)
        .tabItem {
          Label {
            Text("Performance")
          } icon: {
            Image.iconPerformance
              .tint(.pawpBrilliantBlue)
          }
          .labelStyle(.iconOnly)
        }
      }
    }
  }
}
