// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "CxenseSDK",
    products: [
        .library(
            name: "CxenseSDK",
            targets: [
                "CxenseSDK"
            ]
        ),
        .library(
            name: "CxenseSDKTv",
            targets: [
                "CxenseSDKTv"
            ]
        )
    ],
    dependencies: [],
    targets: [
        .binaryTarget(
            name: "CxenseSDK",
            url: "https://s3.amazonaws.com/sdk.cxense.com/CxenseSDK-iOS-1.9.12.zip",
            checksum: "dafcab0fa86db6f194352e8924ef6375f141d1c2a5b3eeb28014d9297335b1fa"
        ),
        .binaryTarget(
            name: "CxenseSDKTv",
            url: "https://s3.amazonaws.com/sdk.cxense.com/CxenseSDK-tvOS-1.9.12.zip",
            checksum: "9d380fd113f31808664b678ae0eb23ec3a96906cfc47eee874659e46ac8487d7"
        )
    ]
)
