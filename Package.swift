// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Main",
  platforms: [.macOS(.v26)],
  dependencies: [
    .package(
      url: "https://github.com/apple/swift-collections",
      exact: "1.2.1"),
    .package(
      url: "https://github.com/apple/swift-algorithms",
      exact: "1.2.1"),
    .package(
      url: "https://github.com/apple/swift-numerics",
      exact: "1.1.0"),
    .package(
      url: "https://github.com/attaswift/BigInt",
      exact: "5.7.0"),
    .package(
      url: "https://github.com/dankogai/swift-bignum",
      revision: "7905f4e520bb601ed02a163d3c7410aa20f39c71"),
    .package(
      url: "https://github.com/keyvariable/kvSIMD.swift",
      exact: "1.1.0"),
    .package(
      url: "https://github.com/brokenhandsio/accelerate-linux",
      revision: "8eda308ea3129130e90e5c01fc437a4c5d2ca278"),
//    .package(
//      url: "https://github.com/narumij/swift-ac-library",
//      branch: "release/AtCoder/2025"),
    .package(
      url: "https://github.com/narumij/swift-ac-library",
      branch: "compatible/AtCoder/2025"),
    .package(
      url: "https://github.com/narumij/swift-ac-foundation",
      branch: "release/AtCoder/2025"),
//    .package(
//      url: "https://github.com/narumij/swift-ac-collections",
//      branch: "release/AtCoder/2025"),
//    .package(
//      url: "https://github.com/narumij/swift-ac-memoize",
//      branch: "release/AtCoder/2025"),
      .package(
        url: "https://github.com/narumij/swift-ac-collections",
        branch: "compatible/AtCoder/2025"),
      .package(
        url: "https://github.com/narumij/swift-ac-memoize",
        from: "0.2.0"),
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .executableTarget(
      name: "Main",
      dependencies: [
        .product(name: "Collections", package: "swift-collections"),
        .product(name: "Algorithms", package: "swift-algorithms"),
        .product(name: "Numerics", package: "swift-numerics"),
        .product(name: "BigInt", package: "BigInt"),
        .product(name: "BigNum", package: "swift-bignum"),
        .product(name: "kvSIMD", package: "kvSIMD.swift"),
        .product(name: "AccelerateLinux", package: "accelerate-linux"),
        .product(name: "AtCoder", package: "swift-ac-library"),
        .product(name: "AcFoundation", package: "swift-ac-foundation"),
        .product(name: "AcCollections", package: "swift-ac-collections"),
        .product(name: "AcMemoize", package: "swift-ac-memoize"),
      ],
      path: "Sources",
      swiftSettings: [
        // .define("ONLINE_JUDGE"),
        .defaultIsolation(nil)
      ]
    )
  ]
)
