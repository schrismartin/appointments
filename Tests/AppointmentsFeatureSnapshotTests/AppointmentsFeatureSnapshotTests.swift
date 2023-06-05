import APIClient
import ComposableArchitecture
import SnapshotTesting
import XCTest

@testable import AppointmentsFeature

@MainActor
final class AppointmentFeatureSnapshotTests: XCTestCase {

  override class func setUp() {
    super.setUp()
    SnapshotTesting.diffTool = "open"
  }

  func testDefault() async {
    let store = StoreOf<AppointmentsReducer>(
      initialState: .init(response: .mock)
    ) {
      AppointmentsReducer()
    } withDependencies: { dependencies in
      dependencies.date = .constant(.mock)
    }

    let view = AppointmentsView(store: store)

    // Note: This test may fail due to changes in the
    assertSnapshot(
      matching: view,
      as: .image(perceptualPrecision: 0.97, layout: .device(config: .iPhone13)),
      record: false
    )
  }

  func testEmpty() async {
    let store = StoreOf<AppointmentsReducer>(
      initialState: .init()
    ) {
      EmptyReducer()
    }

    let view = AppointmentsView(store: store)
    assertSnapshot(matching: view, as: .image(perceptualPrecision: 0.97, layout: .device(config: .iPhone13)))
  }
}
