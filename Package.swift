// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "trace-points",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6)
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
