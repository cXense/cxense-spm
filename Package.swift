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
            url: "https://s3.amazonaws.com/sdk.cxense.com/CxenseSDK-iOS-1.9.5.zip",
            checksum: "636e553c45f7896bc3e1c0c936cd0977239783f4b4828ef543b886643cc68125"
        ),
        .binaryTarget(
            name: "CxenseSDKTv",
            url: "https://s3.amazonaws.com/sdk.cxense.com/CxenseSDK-tvOS-1.9.5.zip",
            checksum: "4ae52f63e0d5c0552a07a4169699f174f4d8869a19e5445c836171ab31ca3280"
        )
    ]
)
