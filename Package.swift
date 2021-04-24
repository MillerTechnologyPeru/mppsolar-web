// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "mppsolar-web",
    platforms: [
        .macOS(.v10_12)
    ],
    products: [
        .executable(
            name: "mppsolar-web",
            targets: ["MPPSolarWeb"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/MillerTechnologyPeru/MPPSolar.git",
            .branch("master")
        ),
        .package(
            url: "https://github.com/apple/swift-argument-parser",
            .upToNextMinor(from: "0.1.0")
        ),
        .package(
            url: "https://github.com/Bouke/NetService.git",
            from: "0.7.0"
        ),
        // Kitura
        .package(
            url: "https://github.com/IBM-Swift/HeliumLogger.git",
            .upToNextMajor(from: "1.8.0")
        ),
        .package(
            url: "https://github.com/IBM-Swift/Kitura.git",
            .upToNextMajor(from: "2.8.0")
        ),
        .package(
            url: "https://github.com/apple/swift-nio.git",
            .exact("2.13.0")
        )
    ],
    targets: [
        .target(
            name: "MPPSolarWeb",
            dependencies: [
                "ArgumentParser",
                "MPPSolar",
                "Kitura"
            ]
        )
    ]
)

#if os(Linux)
package.targets
    .first(where: { $0.name == "MPPSolarWeb" })?
    .dependencies
    .append("NetService")
#endif
