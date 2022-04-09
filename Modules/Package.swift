// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "HeroesFeature", targets: ["HeroesFeature"]),
        .library(name: "CoreNetwork", targets: ["CoreNetwork"]),
        .library(name: "URLSessionHTTPClient", targets: ["URLSessionHTTPClient"]),
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
            name: "CoreHTTPClient",
            dependencies: []
        ),
        .testTarget(
            name: "CoreHTTPClientTests",
            dependencies: []
        ),
        .target(
            name: "CoreNetwork",
            dependencies: []
        ),
        .testTarget(
            name: "CoreNetworkTests",
            dependencies: [
                "CoreNetwork"
            ]
        ),
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
            dependencies: []
        ),
        .testTarget(
            name: "CoreUITests",
            dependencies: ["CoreUI"]
        ),
        .target(
            name: "URLSessionHTTPClient",
            dependencies: [
                "CoreNetwork",
                "CoreHTTPClient"
            ]
        ),
        .testTarget(
            name: "URLSessionHTTPClientTests",
            dependencies: [
                "URLSessionHTTPClient"
            ]
        ),
    ]
)
