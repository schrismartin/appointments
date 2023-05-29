import Application
import AppointmentsFeature
import ComposableArchitecture
import SwiftUI

@main
struct AppointmentsApp: App {
  let store = Store(initialState: .init(appointments: .init(), currentTab: .appointments)) {
    TabsReducer()
  }

  var body: some Scene {
    WindowGroup {
      TabsView(store: store)
    }
  }
}
