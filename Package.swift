// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "LinkerLabel",
  platforms: [.iOS(.v11)],
  products: [
    .library(
      name: "LinkerLabel",
      targets: ["LinkerLabel"]),
  ],
  targets: [
    .target(
      name: "LinkerLabel",
      dependencies: [], path: "Sources/"),
    .testTarget(
      name: "LinkerLabelTests",
      dependencies: ["LinkerLabel"], path: "Tests/"),
  ],
  swiftLanguageVersions: [.v5]
)
