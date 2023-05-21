// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "CustomControlFeatures",
  platforms: [
    .macOS(.v13),
  ],
  
  products: [
    .library(name: "ApiIntView", targets: ["ApiIntView"]),
    .library(name: "ApiStringView", targets: ["ApiStringView"]),
    .library(name: "LevelIndicatorView", targets: ["LevelIndicatorView"]),
    .library(name: "ProgressFeature", targets: ["ProgressFeature"]),
  ],
  
  dependencies: [
    // ----- OTHER -----
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.42.0"),
  ],
  
  targets: [
    // --------------- Modules ---------------
    // ApiIntView
    .target(name: "ApiIntView", dependencies: [
    ]),
    
    // ApiStringView
    .target(name: "ApiStringView", dependencies: [
    ]),
    
    // LevelIndicatorView
    .target(name: "LevelIndicatorView", dependencies: [
    ]),

    // ProgressFeature
    .target(name: "ProgressFeature", dependencies: [
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),

    // ---------------- Tests ----------------
  ]
)
