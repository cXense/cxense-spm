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
            url: "https://s3.amazonaws.com/sdk.cxense.com/CxenseSDK-iOS-1.10.2.zip",
            checksum: "ab535b713d53a60165d835a122c3fefe87c2cf1ba225da513e54b0ec409347ee"
        ),
        .binaryTarget(
            name: "CxenseSDKTv",
            url: "https://s3.amazonaws.com/sdk.cxense.com/CxenseSDK-tvOS-1.10.2.zip",
            checksum: "71ae3e051abcfcd3096b60c0c2def790b05be12cdfd46138da318cb058053150"
        )
    ]
)
