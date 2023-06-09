import ComposableArchitecture
import StyleGuide
import SwiftUI

struct UnreadConversationCardView: View {

  var store: StoreOf<UnreadConversationCardReducer>

  struct ViewState: Equatable {
    var nameComponents: PersonNameComponents
    var timestampDate: Date
    var lastMessage: String?

    init(state: UnreadConversationCardReducer.State) {
      self.nameComponents = state.appointment.user.components
      self.timestampDate = state.appointment.timestampDate
      self.lastMessage = state.appointment.lastMessage
    }
  }

  var body: some View {
    WithViewStore(store, observe: ViewState.init) { viewStore in
      CardLayout {
        HStack(alignment: .center, spacing: 9) {
          Circle()
            .frame(width: 8, height: 8)
            .foregroundColor(.accentColor)
            .opacity(1)

          AvatarView(components: viewStore.nameComponents, color: .avatarRed)
        }
      } header: {
        VStack(alignment: .leading) {
          Text("\(viewStore.nameComponents, format: .name(style: .long))")
            .font(.aeonikTitle2)
        }
      } headerDetail: {
        Text("\(viewStore.timestampDate, format: .dateTime.hour().minute())")
          .font(.aeonikCaption)
      } content: {
        if let lastMessage = viewStore.lastMessage {
          Text(verbatim: lastMessage)
            .font(.aeonikBody)
        }
      } buttons: {
        // There are no buttons on this card
      }
      .accentColor(.avatarRed)
    }
  }
}

#if DEBUG

struct UnreadConversationCardView_Previews: PreviewProvider {
  static var previews: some View {
    UnreadConversationCardView(
      store: Store(initialState: .init(appointment: .mock)) {
        UnreadConversationCardReducer()
      }
    )
    .previewLayout(.sizeThatFits)
  }
}

#endif
