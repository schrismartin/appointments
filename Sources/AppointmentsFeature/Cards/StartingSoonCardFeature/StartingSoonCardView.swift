import ComposableArchitecture
import StyleGuide
import SwiftUI

struct StartingSoonCardView: View {

  var store: StoreOf<StartingSoonCardReducer>

  struct ViewState: Equatable {
    var nameComponents: PersonNameComponents
    var timestampDate: Date
    var formattedRelativeStartDate: String
    var startDate: Date

    init(state: StartingSoonCardReducer.State) {
      self.nameComponents = state.appointment.user.components
      self.timestampDate = state.appointment.timestampDate
      self.formattedRelativeStartDate = state.formattedRelativeStartDate
      self.startDate = state.appointment.startTime
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

          Image.iconNotification
        }
      } header: {
        VStack(alignment: .leading) {
          Text("Starting soon")
            .font(.aeonikHeadline)
            .foregroundColor(.accentColor)

          Text("\(viewStore.nameComponents, format: .name(style: .long))")
            .font(.aeonikTitle2)
        }
      } headerDetail: {
        Text("\(viewStore.timestampDate, format: .dateTime.hour().minute())")
          .font(.aeonikCaption)
      } content: {
        Text(
          """
          Your appointment with \(viewStore.nameComponents, format: .name(style: .short)) begins \
          \(viewStore.formattedRelativeStartDate)
          """
        )
        .font(.aeonikBody)
      } buttons: {
        Button("Join Appointment") {
          viewStore.send(.delegate(.joinAppointmentButtonPressed))
        }
        .buttonStyle(.primary)
      }
      .accentColor(.pawpLiveGreen)
    }
  }
}

struct StartingSoonCardView_Previews: PreviewProvider {
  static var previews: some View {
    StartingSoonCardView(
      store: Store(initialState: .init(appointment: .mock)) {
        StartingSoonCardReducer()
      }
    )
    .previewLayout(.sizeThatFits)
  }
}
