import SwiftUI

public struct AvatarView: View {
  var components: PersonNameComponents
  var color: Color
  
  public init(components: PersonNameComponents, color: Color) {
    self.components = components
    self.color = color
  }
  
  public var body: some View {
    Circle()
      .foregroundColor(.accentColor)
      .frame(width: 32, height: 32, alignment: .center)
      .overlay {
        Text("\(components, format: .name(style: .abbreviated))")
          .font(.aeonikCaption)
          .bold()
          .foregroundColor(.white)
      }
  }
}
