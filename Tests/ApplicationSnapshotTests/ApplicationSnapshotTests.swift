import APIClient
import ComposableArchitecture
import SnapshotTesting
import XCTest

@testable import Application

@MainActor
final class ApplicationSnapshotTests: XCTestCase {

  override class func setUp() {
    super.setUp()
    SnapshotTesting.diffTool = "open"
  }

  func testDefault() async {
    let store = StoreOf<TabsReducer>(
      initialState: TabsReducer.State(
        appointments: .init(response: .mock),
        currentTab: .appointments
      )
    ) {
      EmptyReducer()
    } withDependencies: { dependencies in
      dependencies.date = .constant(.mock)
    }

    let view = TabsView(store: store)

    // Note: This test may fail due to changes in the
    assertSnapshot(
      matching: view,
      as: .image(perceptualPrecision: 0.97, layout: .device(config: .iPhone13)),
      record: false
    )
  }

  func testEmpty() async {
    let store = StoreOf<TabsReducer>(
      initialState: TabsReducer.State(
        appointments: .init(),
        currentTab: .appointments
      )
    ) {
      EmptyReducer()
    }

    let view = TabsView(store: store)
    assertSnapshot(matching: view, as: .image(perceptualPrecision: 0.97, layout: .device(config: .iPhone13)))
  }
}
