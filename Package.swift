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
            path: "Wrapper",
            resources: [
                .copy("Resources/PrivacyInfo.xcprivacy")
            ]
        ),
        .binaryTarget(
            name: "CxenseSDK",
            url: "https://s3.amazonaws.com/sdk.cxense.com/CxenseSDK-iOS-1.10.0.zip",
            checksum: "f839d3f6814913d47a58d518c57e2a00f3f04053c1029bdc14a09881afb9c5fe"
        ),
        .binaryTarget(
            name: "CxenseSDKTv",
            url: "https://s3.amazonaws.com/sdk.cxense.com/CxenseSDK-tvOS-1.10.0.zip",
            checksum: "551ccfa6a8024a07c64711d2f0892a06608e22f61ce46bd867f1493c968800ff"
        )
    ]
)
