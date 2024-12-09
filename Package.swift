// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "CxenseSDK",
    products: [
        .library(
            name: "CxenseSDK",
            targets: [
                "CxenseSDKWrapper"
            ]
        ),
        .library(
            name: "CxenseSDKTv",
            targets: [
                "CxenseSDKTvWrapper"
            ]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CxenseSDKWrapper",
            dependencies: ["CxenseSDK"],
            path: "Wrapper",
            resources: [
                .copy("Resources/PrivacyInfo.xcprivacy")
            ]
        ),
        .target(
            name: "CxenseSDKTvWrapper",
            dependencies: ["CxenseSDKTv"],
            path: "WrapperTv",
            resources: [
                .copy("Resources/PrivacyInfo.xcprivacy")
            ]
        ),
        .binaryTarget(
            name: "CxenseSDK",
            url: "https://s3.amazonaws.com/sdk.cxense.com/CxenseSDK-iOS-1.10.0.zip",
            checksum: "a41788306fefd9ee372ab6a1ff0eed08a539aa74f68f9205c93fb0f90d059a44"
        ),
        .binaryTarget(
            name: "CxenseSDKTv",
            url: "https://s3.amazonaws.com/sdk.cxense.com/CxenseSDK-tvOS-1.10.0.zip",
            checksum: "5d200bde8d74c493bb8e356d26fab68f36039f5e94956c06f2eb04a5ae87ba2b"
        )
    ]
)
