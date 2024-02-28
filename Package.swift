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
        .executable(
            name: "maximize",
            targets: ["maximize"]),
    ],
    targets: [
        .target(
            name: "blocks"),
        .executableTarget(
            name: "tariff",
            dependencies: ["blocks"]),
        .executableTarget(
            name: "maximize",
            dependencies: ["blocks"]),
        .testTarget(
            name: "blocksTests",
            dependencies: ["blocks"]),
    ]
)
