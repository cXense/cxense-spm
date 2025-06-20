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
            url: "https://s3.amazonaws.com/sdk.cxense.com/CxenseSDK-iOS-1.10.3.zip",
            checksum: "8684af7ee2c99557f45ac5f24313a62ba05609ad00ec7824ef453cdbd02b6cf7"
        ),
        .binaryTarget(
            name: "CxenseSDKTv",
            url: "https://s3.amazonaws.com/sdk.cxense.com/CxenseSDK-tvOS-1.10.3.zip",
            checksum: "fae6cca4e68544490545def467b10fea76451be4e9386d3e06a93a4cabb0fb36"
        )
    ]
)
