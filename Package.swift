// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "appointments",
  platforms: [
    .iOS(.v16)
  ],
  products: [
    .library(
      name: "Application",
      targets: ["Application", "AppointmentsFeature"]
    )
  ],
  dependencies: [
    .package(
      url: "https://github.com/pointfreeco/swift-composable-architecture.git",
      revision: "b2815caa1727d72180836b85578272b763cc4853"  // prerelease/1.0
    ),
    .package(
      url: "https://github.com/pointfreeco/swift-dependencies.git",
      from: "0.5.0"
    ),
    .package(
      url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
      from: "1.11.0"
    ),
  ],
  targets: [
    .target(
      name: "APIClient",
      dependencies: [
        .product(name: "Dependencies", package: "swift-dependencies")
      ]
    ),
    .target(
      name: "Application",
      dependencies: [
        "AppointmentsFeature",
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      ],
      resources: [
        .process("Resources/Assets.xcassets")
      ]
    ),
    .testTarget(
      name: "ApplicationSnapshotTests",
      dependencies: [
        "Application",
        .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
      ]
    ),
    .target(
      name: "AppointmentsFeature",
      dependencies: [
        "APIClient",
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        "Primitives",
        "StyleGuide",
      ],
      resources: [
        .process("Resources/Assets.xcassets")
      ]
    ),
    .testTarget(
      name: "AppointmentsFeatureTests",
      dependencies: [
        "AppointmentsFeature"
      ]
    ),
    .target(
      name: "Primitives",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
      ]
    ),
    .target(
      name: "StyleGuide",
      dependencies: [],
      resources: [
        .process("Resources/Fonts")
      ]
    ),
  ]
)
