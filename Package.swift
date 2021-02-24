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
            url: "https://s3.amazonaws.com/sdk.cxense.com/CxenseSDK-iOS-1.9.2.zip",
            checksum: "028a333d180d8db39662f38532d0834f4bbd085a2d36da833ffd0b9c81f1ff5a"
        ),
        .binaryTarget(
            name: "CxenseSDK_TV",
            url: "https://s3.amazonaws.com/sdk.cxense.com/CxenseSDK-tvOS-1.9.2.zip",
            checksum: "3359e6443558b9bbc82896ee0631261cec8163f58cf29ce822bef83022a02f2d"
        )
    ]
)
