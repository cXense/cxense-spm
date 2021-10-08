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
            url: "https://s3.amazonaws.com/sdk.cxense.com/CxenseSDK-iOS-1.9.5.1.zip",
            checksum: "156fcb349594494f021f61040ffec852088924dfd9212f3632ceb19473eb7037"
        ),
        .binaryTarget(
            name: "CxenseSDK_TV",
            url: "https://s3.amazonaws.com/sdk.cxense.com/CxenseSDK-tvOS-1.9.5.1.zip",
            checksum: "d8603b5fcf54ab372c16833d3f4e728fb52310c1eeae991d7408df68271ebb7a"
        )
    ]
)
