import ComposableArchitecture
import StyleGuide
import SwiftUI

struct UnreadAppointmentRequestCardView: View {

  var store: StoreOf<UnreadAppointmentRequestCardReducer>

  struct ViewState: Equatable {
    var nameComponents: PersonNameComponents
    var requestedDate: Date
    var startDate: Date

    init(state: UnreadAppointmentRequestCardReducer.State) {
      self.nameComponents = state.appointment.user.components
      self.requestedDate = state.appointment.requestedAt
      self.startDate = state.appointment.startTime
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

          Image.iconRequest
        }
      } header: {
        VStack(alignment: .leading) {
          Text("Request to book")
            .font(.aeonikHeadline)
            .foregroundColor(.accentColor)

          Text("\(viewStore.nameComponents, format: .name(style: .long))")
            .font(.aeonikTitle2)
        }
      } headerDetail: {
        Text("\(viewStore.requestedDate, format: .dateTime.hour().minute())")
          .font(.aeonikCaption)
      } content: {
        Text(
          """
          \(viewStore.nameComponents, format: .name(style: .short)) has requested an appointment on \
          \(Text("\(viewStore.startDate, formatter: Self.dateFormatter)").bold())
          """
        )
        .font(.aeonikBody)
      } buttons: {
        Button("Accept") {
          viewStore.send(.delegate(.acceptButtonPressed), animation: .default)
        }
        .buttonStyle(.primary)
        Button("Decline") {
          viewStore.send(.delegate(.declineButtonPressed), animation: .default)
        }
        .buttonStyle(.secondary)
      }
      .accentColor(.pawpBrilliantBlue)
    }
  }
}

struct UnreadAppointmentRequestCardView_Previews: PreviewProvider {
  static var previews: some View {
    UnreadAppointmentRequestCardView(
      store: Store(initialState: .init(appointment: .mock)) {
        UnreadAppointmentRequestCardReducer()
      }
    )
    .previewLayout(.sizeThatFits)
  }
}
