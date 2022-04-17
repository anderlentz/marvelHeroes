// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "Feature-Heroes", targets: ["Feature-Heroes"]),
        .library(name: "CoreNetwork", targets: ["CoreNetwork"]),
        .library(name: "URLSessionHTTPClient", targets: ["URLSessionHTTPClient"]),
        .library(name: "HeroesAPI", targets: ["HeroesAPI"]),
        .library(name: "CoreHTTPClient", targets: ["CoreHTTPClient"]),
        .library(name: "Feature-HeroDetails", targets: ["Feature-HeroDetails"]),
        .library(name: "CoreUtils", targets: ["CoreUtils"])
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
            name: "CoreUtils",
            dependencies: []
        ),
        .target(
            name: "HeroesAPI",
            dependencies: [
                "CoreNetwork",
                "Feature-Heroes",
                "Feature-HeroDetails"
            ]
        ),
        .testTarget(
            name: "HeroesAPITests",
            dependencies: [
                "HeroesAPI"
            ]
        ),
        .target(
            name: "Feature-Heroes",
            dependencies: [
                "CoreUI",
                "CoreUtils",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .testTarget(
            name: "Feature-HeroesTests",
            dependencies: [
                "Feature-Heroes",
                .product(name: "SnapshotTesting", package: "swift-composable-architecture"),
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
        .target(
            name: "Feature-HeroDetails",
            dependencies: [
                "CoreUI",
                "CoreUtils",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .testTarget(
            name: "Feature-HeroDetailsTests",
            dependencies: [
                "Feature-HeroDetails",
                .product(name: "SnapshotTesting", package: "swift-composable-architecture"),
            ]
        ),
    ]
)
