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
            dependencies: ["ConnectSDKCore", "ConnectSDKNoARC", "ConnectSDKGoogleCast"]),
        .target(
            name: "ConnectSDKCore",
            dependencies: ["ConnectSDKNoARC"],
            path: "core",
            exclude: ["ConnectSDK*Tests"],
            sources: ["ConnectSDKDefaultPlatforms.h", "core/**/*.{h,m}"],
            publicHeadersPath: "core",
            cSettings: [
                .headerSearchPath("core/Frameworks/LGCast"),
                .headerSearchPath("core/Frameworks/asi-http-request/External/Reachability"),
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
            path: "core",
            exclude: ["ConnectSDK*Tests", "core/Frameworks/LGCast/**/*.h"],
            sources: ["core/Frameworks/asi-http-request/External/Reachability/*.{h,m}", "core/Frameworks/asi-http-request/Classes/*.{h,m}"],
            cSettings: [
                .headerSearchPath("core/Frameworks/LGCast"),
                .headerSearchPath("core/Frameworks/asi-http-request/External/Reachability"),
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
                .headerSearchPath("core/Frameworks/LGCast"),
                .define("CONNECT_SDK_VERSION", to: "\"2.0.0\""),
            ],
            linkerSettings: [
                .linkedFramework("GoogleCast"),
                .unsafeFlags(["-F", "$(PODS_ROOT)/google-cast-sdk/GoogleCastSDK-2.7.1-Release"]),
            ]
        ),
    ]
)
