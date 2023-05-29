import ComposableArchitecture
import SwiftUI

struct AppointmentView: View {
  var store: StoreOf<AppointmentReducer>

  var body: some View {
    SwitchStore(store) { state in
      switch state {
      case .unreadRequest:
        CaseLet(
          /AppointmentReducer.State.unreadRequest,
          action: AppointmentReducer.Action.unreadRequest,
          then: UnreadAppointmentRequestCardView.init(store:)
        )
      case .startingSoon:
        CaseLet(
          /AppointmentReducer.State.startingSoon,
          action: AppointmentReducer.Action.startingSoon,
          then: StartingSoonCardView.init(store:)
        )

      case .unreadConversation:
        CaseLet(
          /AppointmentReducer.State.unreadConversation,
          action: AppointmentReducer.Action.unreadConversation,
          then: UnreadConversationCardView.init(store:)
        )

      case .ended:
        CaseLet(
          /AppointmentReducer.State.ended,
          action: AppointmentReducer.Action.ended,
          then: EndedCardView.init(store:)
        )
      }
    }
  }
}
