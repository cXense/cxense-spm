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
            url: "https://s3.amazonaws.com/sdk.cxense.com/CxenseSDK-iOS-1.10.6.zip",
            checksum: "eb07b8ac5cd28958f036c6315dd50db80809dacd4805c05dd1ccd8e2e90cee96"
        ),
        .binaryTarget(
            name: "CxenseSDKTv",
            url: "https://s3.amazonaws.com/sdk.cxense.com/CxenseSDK-tvOS-1.10.6.zip",
            checksum: "8d3876f765355e0f9be97145005cd0744974d6fc7e397ebc4f0226839a4fc474"
        )
    ]
)
