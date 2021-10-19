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
                "CxenseSDK_TV"
            ]
        )
    ],
    dependencies: [],
    targets: [
        .binaryTarget(
            name: "CxenseSDK",
            url: "https://s3.amazonaws.com/sdk.cxense.com/CxenseSDK-iOS-1.9.6.zip",
            checksum: "592d3ba6e6b54b4dab4c740ea1079090d7f112098c508b9431bd095ef970c623"
        ),
        .binaryTarget(
            name: "CxenseSDK_TV",
            url: "https://s3.amazonaws.com/sdk.cxense.com/CxenseSDK-tvOS-1.9.6.zip",
            checksum: "b7828259643508b29b3c6a35b7896e6914e6f7cefd08b260859f90e5cfca5e55"
        )
    ]
)
