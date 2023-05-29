// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Appointments",
  platforms: [
    .iOS(.v16)
  ],
  products: [
    .library(
      name: "Application",
      targets: ["Application", "AppointmentsFeature"]
    ),
  ],
  dependencies: [
    .package(
      url: "https://github.com/pointfreeco/swift-composable-architecture.git",
      revision: "b29e8987200ffd58741748866c9e66d97a95a595"
    ),
    .package(
      url: "https://github.com/pointfreeco/swift-dependencies.git",
      from: "0.5.0"
    )
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
      name: "ApplicationTests",
      dependencies: [
        "Application"
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
    .target(
      name: "Primitives",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      ]
    ),
    .target(
      name: "StyleGuide",
      dependencies: [],
      resources: [
        .process("Resources/Fonts")
      ]
    ),
    .target(
      name: "TabsFeature",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      ]
    )
  ]
)
