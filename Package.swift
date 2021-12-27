// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SweetSimpleSwift",
  platforms: [
    .iOS(.v14)
  ],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "SweetSimpleSwift",
      targets: ["SweetSimpleSwift"]),
  ],
  dependencies: [
    
    .package(name: "Firebase",
             url: "https://github.com/firebase/firebase-ios-sdk.git",
             branch: "master"),
//    .package(name: "GoogleSignIn",
//             url: "https://github.com/google/GoogleSignIn-iOS",
//             .upToNextMajor(from: "6.0.0")),
    .package(name: "Facebook",
             url: "https://github.com/facebook/facebook-ios-sdk",
             .upToNextMajor(from: "9.0.0")),
    // ...
    
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "SweetSimpleSwift",
      dependencies: [
        .product(name: "FirebaseAuth", package: "Firebase"),
        .product(name: "FacebookLogin", package: "Facebook"),
//        .product(name: "GoogleSignIn", package: "GoogleSignIn"),
        // ...
      ]
    ),
    
  ],
  swiftLanguageVersions: [.v5]
)
