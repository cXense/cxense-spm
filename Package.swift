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
            url: "https://s3.amazonaws.com/sdk.cxense.com/CxenseSDK-iOS-1.9.7.zip",
            checksum: "db9d8867dc5adc4f1d4c7f1e1442f249cd989f7e9906b9c568a5b919316b5bda"
        ),
        .binaryTarget(
            name: "CxenseSDKTv",
            url: "https://s3.amazonaws.com/sdk.cxense.com/CxenseSDK-tvOS-1.9.7.zip",
            checksum: "6ac0fa5bd5790fc4ae52c3cd8f45b0c3c0a759a2f49995193d31cbc603c826da"
        )
    ]
)
