// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Pastel",
    products: [
        .library(
            name: "Pastel",
            targets: ["Pastel"]),
    ],
    targets: [
        .target(
            name: "Pastel",
            dependencies: [],
            path: "Pastel"
        ),
        .testTarget(
            name: "PastelTests",
            dependencies: ["Pastel"],
            path: "PastelTests"
        ),
    ]
)
