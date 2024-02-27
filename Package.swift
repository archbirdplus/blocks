// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "blocks",
    products: [
        // The library
        .library(
            name: "blocks",
            targets: ["blocks"]),
        // The commandline frontend for the library
        .executable(
            name: "tariff",
            targets: ["tariff"]),
    ],
    targets: [
        .executableTarget(
            name: "tariff",
            dependencies: ["blocks"]),
        .target(
            name: "blocks"),
        .testTarget(
            name: "blocksTests",
            dependencies: ["blocks"]),
    ]
)
