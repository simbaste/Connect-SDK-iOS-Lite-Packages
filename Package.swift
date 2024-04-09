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
            dependencies: ["ConnectSDKCore", "ConnectSDKNoARC", "ConnectSDKGoogleCast"],
            path: "Sources/ConnectSDK"
        ),
        .target(
            name: "ConnectSDKCore",
            dependencies: ["ConnectSDKNoARC"],
            path: "Sources/ConnectSDKCore",
            exclude: ["ConnectSDK*Tests"],
            sources: ["ConnectSDKDefaultPlatforms.h", "Sources/ConnectSDKCore/**/*.{h,m}"],
            publicHeadersPath: "Sources/ConnectSDKCore",
            cSettings: [
                .headerSearchPath("Sources/ConnectSDKCore/Frameworks/LGCast"),
                .headerSearchPath("Sources/ConnectSDKCore/Frameworks/asi-http-request/External/Reachability"),
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
            name: "ConnectSDKNoARC",
            path: "Sources/ConnectSDKNoARC",
            exclude: ["ConnectSDK*Tests", "Sources/ConnectSDKNoARC/Frameworks/LGCast/**/*.h"],
            sources: ["Sources/ConnectSDKNoARC/Frameworks/asi-http-request/External/Reachability/*.{h,m}", "Sources/ConnectSDKNoARC/Frameworks/asi-http-request/Classes/*.{h,m}"],
            cSettings: [
                .headerSearchPath("Sources/ConnectSDKNoARC/Frameworks/LGCast"),
                .headerSearchPath("Sources/ConnectSDKNoARC/Frameworks/asi-http-request/External/Reachability"),
                .unsafeFlags(["-w"]),
            ]
        ),
        .target(
            name: "ConnectSDKGoogleCast",
            dependencies: ["ConnectSDKCore"],
            path: "modules/google-cast",
            exclude: ["*Tests"],
            sources: ["**/*.{h,m}"],
            publicHeadersPath: "modules/google-cast",
            cSettings: [
                .headerSearchPath("Sources/ConnectSDKCore/Frameworks/LGCast"),
                .define("CONNECT_SDK_VERSION", to: "\"2.0.0\""),
            ],
            linkerSettings: [
                .linkedFramework("GoogleCast"),
            ]
        ),
    ]
)

