// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Pastel",
    platforms: [.iOS(.v16)],
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
