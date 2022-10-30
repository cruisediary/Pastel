// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Pastel",
    products: [
        .library(
            name: "Pastel",
            targets: ["Pastel"]
        ),
    ],
    targets: [
        .target(
            name: "Pastel",
            dependencies: []),
        .testTarget(
            name: "PastelTests",
            dependencies: ["Pastel"]),
    ]
)
