// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "trace-points",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v11),
        .tvOS(.v11),
        .watchOS(.v4)
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
