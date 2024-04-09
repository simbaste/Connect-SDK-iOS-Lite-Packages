// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "ConnectSDK",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "ConnectSDK",
            targets: ["ConnectSDK"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ConnectSDK/Connect-SDK-iOS.git", .exact("2.0.0")),
        // Add any additional dependencies here
    ],
    targets: [
        .target(
            name: "ConnectSDK",
            dependencies: ["Core", "NoARC", "GoogleCast"],
            path: "ConnectSDK"
        ),
        .target(
            name: "Core",
            dependencies: ["NoARC"],
            url: "https://github.com/ConnectSDK/Connect-SDK-iOS-Core.git",
            path: "ConnectSDK/Core",
            exclude: ["ConnectSDK*Tests"],
            sources: ["ConnectSDKDefaultPlatforms.h", "ConnectSDK/Core/**/*.{h,m}"],
            publicHeadersPath: "ConnectSDK/Core",
            cSettings: [
                .headerSearchPath("ConnectSDK/Core/Frameworks/LGCast"),
                .headerSearchPath("ConnectSDK/Core/Frameworks/asi-http-request/External/Reachability"),
                .define("CONNECT_SDK_VERSION", to: "\"2.0.0\""),
                .define("kConnectSDKWirelessSSIDChanged", to: "\"Connect_SDK_Wireless_SSID_Changed\""),
            ],
            linkerSettings: [
                .linkedLibrary("z"),
                .linkedLibrary("icucore"),
                .unsafeFlags(["-ObjC"]),
            ]
        ),
        .target(
            name: "NoARC",
            path: "ConnectSDK/NoARC",
            exclude: ["ConnectSDK*Tests", "ConnectSDK/NoARC/Frameworks/LGCast/**/*.h"],
            sources: ["ConnectSDK/NoARC/Frameworks/asi-http-request/External/Reachability/*.{h,m}", "ConnectSDK/NoARC/Frameworks/asi-http-request/Classes/*.{h,m}"],
            cSettings: [
                .headerSearchPath("ConnectSDK/NoARC/Frameworks/LGCast"),
                .headerSearchPath("ConnectSDK/NoARC/Frameworks/asi-http-request/External/Reachability"),
                .unsafeFlags(["-w"]),
            ]
        ),
        .target(
            name: "GoogleCast",
            dependencies: ["Core"],
            path: "ConnectSDK/modules/google-cast",
            exclude: ["*Tests"],
            sources: ["**/*.{h,m}"],
            publicHeadersPath: "ConnectSDK/modules/google-cast",
            cSettings: [
                .headerSearchPath("ConnectSDK/Core/Frameworks/LGCast"),
                .define("CONNECT_SDK_VERSION", to: "\"2.0.0\""),
            ],
            linkerSettings: [
                .linkedFramework("GoogleCast"),
            ]
        ),
    ]
)

