// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "Modules",
            targets: [
                "HeroesFeature"
            ]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
            from: "1.9.0"
          ),
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture",
            from: "0.9.0"
        )
    ],
    targets: [
        .target(
            name: "HeroesFeature",
            dependencies: [
                "CoreUI",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .testTarget(
            name: "HeroesFeatureTests",
            dependencies: [
                "HeroesFeature",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ]
        ),
        .target(
            name: "CoreUI",
            dependencies: []),
        .testTarget(
            name: "CoreUITests",
            dependencies: ["CoreUI"]
        ),
        
    ]
)
