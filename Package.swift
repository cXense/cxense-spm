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
            url: "https://s3.amazonaws.com/sdk.cxense.com/CxenseSDK-iOS-1.9.10.zip",
            checksum: "4d46ceb5482f1e5d7905b63dab4f9904c9347bc8b43741fdc89c438c274a138c"
        ),
        .binaryTarget(
            name: "CxenseSDKTv",
            url: "https://s3.amazonaws.com/sdk.cxense.com/CxenseSDK-tvOS-1.9.10.zip",
            checksum: "60752ca33ee214e93a13385bb99bb2ecf94b5bcabf374a18354894235b482d83"
        )
    ]
)
