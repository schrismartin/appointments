import ComposableArchitecture
import StyleGuide
import SwiftUI

struct EndedCardView: View {

  var store: StoreOf<EndedCardReducer>

  struct ViewState: Equatable {
    var nameComponents: PersonNameComponents
    var timestampDate: Date
    var lastMessage: String?

    init(state: EndedCardReducer.State) {
      self.nameComponents = state.appointment.user.components
      self.timestampDate = state.appointment.timestampDate
      self.lastMessage = state.appointment.lastMessage
    }
  }

  static let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "E, MMM d @ h:mm a"
    formatter.timeZone = .autoupdatingCurrent
    return formatter
  }()

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
        Text("This conversation has ended.")
          .font(.aeonikBody)
      } buttons: {
        // There are no buttons on this card
      }
      .accentColor(.inactiveForeground)
    }
  }
}

struct EndedCardView_Previews: PreviewProvider {
  static var previews: some View {
    EndedCardView(
      store: Store(initialState: .init(appointment: .mock)) {
        EndedCardReducer()
      }
    )
    .previewLayout(.sizeThatFits)
  }
}
