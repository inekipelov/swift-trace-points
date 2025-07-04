// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "trace-points",
    platforms: [
        .macOS(.v10_10),
        .iOS(.v9),
        .tvOS(.v9),
        .watchOS(.v2)
    ],
    products: [
        .library(
            name: "TracePoints",
            targets: ["TracePoints"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "TracePoints",
            dependencies: [],
            path: "Sources"),
        .testTarget(
            name: "TracePointsTests",
            dependencies: ["TracePoints"],
            path: "Tests"),
    ]
)