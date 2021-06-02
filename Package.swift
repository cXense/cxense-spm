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
            url: "https://s3.amazonaws.com/sdk.cxense.com/CxenseSDK-iOS-1.9.4.zip",
            checksum: "3ba2225645c7a6d2715e63a6cedfc0bff92e61777e418004f55ec44bb8c8be33"
        ),
        .binaryTarget(
            name: "CxenseSDK_TV",
            url: "https://s3.amazonaws.com/sdk.cxense.com/CxenseSDK-tvOS-1.9.4.zip",
            checksum: "d07fd95e479e9b4f312f4bfa81c2bf62bf67c462cf6fe67da93b15fe34fa7068"
        )
    ]
)
