import StyleGuide
import SwiftUI

struct CardLayout<
  Icon: View,
  Header: View,
  HeaderDetail: View,
  Content: View,
  Buttons: View
>: View {
  var icon: Icon
  var header: Header
  var headerDetail: HeaderDetail
  var content: Content
  var buttons: Buttons

  init(
    @ViewBuilder icon: @escaping () -> Icon,
    @ViewBuilder header: @escaping () -> Header,
    @ViewBuilder headerDetail: @escaping () -> HeaderDetail,
    @ViewBuilder content: @escaping () -> Content,
    @ViewBuilder buttons: @escaping () -> Buttons
  ) {
    self.icon = icon()
    self.header = header()
    self.headerDetail = headerDetail()
    self.content = content()
    self.buttons = buttons()
  }

  var body: some View {
    Grid(horizontalSpacing: 12) {
      GridRow(alignment: .center) {
        icon

        HStack {
          header
            .frame(maxWidth: .infinity, alignment: .leading)
          Spacer()
          headerDetail
        }
      }

      Spacer(minLength: 4)

      GridRow {
        Spacer()

        content
          .frame(maxWidth: .infinity, alignment: .leading)
          .lineLimit(2, reservesSpace: false)
          .foregroundColor(.secondary)
      }

      if Buttons.self != EmptyView.self {
        Spacer(minLength: 12)

        GridRow {
          Spacer()
          ViewThatFits {
            HStack {
              buttons
            }

            VStack {
              buttons
            }
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }
      }
    }
  }
}

struct CardLayout_Previews: PreviewProvider {
  static var previews: some View {
    CardLayout {
      HStack(alignment: .center, spacing: 9) {
        Circle()
          .frame(width: 8, height: 8)
          .foregroundColor(.accentColor)
          .opacity(1)

        Image("icon-request", bundle: .module)
      }
    } header: {
      VStack(alignment: .leading) {
        Text("Request to book")
          .font(.aeonikHeadline)
          .foregroundColor(.pawpBrilliantBlue)

        Text("Laura Skelvo")
          .font(.aeonikTitle)
      }
      .bold()
    } headerDetail: {
      Text("5:46pm")
        .font(.aeonikCaption)
    } content: {
      Text(
        """
        Laura has requested an appointment on \
        \(Text("Tue, May 18 @ 9:30am").bold())
        """
      )
      .font(.aeonikBody)
    } buttons: {
      Button("Accept") {
        //
      }
      .buttonStyle(.primary)
      Button("Decline") {
        //
      }
      .buttonStyle(.secondary)
    }
    .tint(.pawpBrilliantBlue)
    .padding()
    .previewLayout(.fixed(width: 600, height: 160))
  }
}
