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
    dependencies: [],
    targets: [
        .target(
            name: "HeroesFeature",
            dependencies: [
                "CoreUI"
            ]
        ),
        .testTarget(
            name: "HeroesFeatureTests",
            dependencies: ["HeroesFeature"]
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
