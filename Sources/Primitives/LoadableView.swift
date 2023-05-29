import SwiftUI

public struct LoadableView<Model, Content: View, Failure: View>: View {
  var model: Loadable<Model>
  var placeholder: Model
  var content: (Model) -> Content
  var failure: (Error) -> Failure

  public init(
    model: Loadable<Model>,
    placeholder: Model,
    @ViewBuilder content: @escaping (Model) -> Content,
    @ViewBuilder failure: @escaping (Error) -> Failure
  ) {
    self.model = model
    self.placeholder = placeholder
    self.content = content
    self.failure = failure
  }

  public var body: some View {
    ZStack {
      content(model.success ?? placeholder)
        .redacted(reason: model.success != nil ? [] : .placeholder)
        .disabled(!model.isComplete)

      if let error = model.failure {
        Rectangle()
          .foregroundColor(Color(.systemBackground))
          .edgesIgnoringSafeArea(.all)
          .overlay {
            failure(error)
          }
      }
    }
  }
}

extension LoadableView where Model: Mockable {
  public init(
    model: Loadable<Model>,
    @ViewBuilder content: @escaping (Model) -> Content,
    @ViewBuilder failure: @escaping (Error) -> Failure
  ) {
    self.init(model: model, placeholder: .mock, content: content, failure: failure)
  }
}
