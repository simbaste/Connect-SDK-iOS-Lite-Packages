// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "ConnectSDK-Lite",
    products: [
        .library(
            name: "ConnectSDK-Lite",
            targets: ["ConnectSDK-Lite"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "ConnectSDK-Lite",
            url: "https://github.com/simbaste/Connect-SDK-iOS-Lite-Packages/blob/main/ConnectSDK-Lite-2.0.0.xcframework.zip",
        )
    ]
)