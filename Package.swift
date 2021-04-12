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
            url: "https://s3.amazonaws.com/sdk.cxense.com/CxenseSDK-iOS-1.9.3.zip",
            checksum: "bfefba4d6576cb8bfc9733ede61a018e29802164c449ee0592f3040b69f64552"
        ),
        .binaryTarget(
            name: "CxenseSDK_TV",
            url: "https://s3.amazonaws.com/sdk.cxense.com/CxenseSDK-tvOS-1.9.3.zip",
            checksum: "0274a6a45b74a475ae7834ecf02ec0b0573814aca0726f9cf807ea4094936abc"
        )
    ]
)
