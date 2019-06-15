// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "Graphics",
    products: [
        .library(name: "Geometry", targets: ["Geometry"]),
        .library(name: "Path", targets: ["Path"]),
        .library(name: "Rendering", targets: ["Rendering"]),
        .library(name: "SVG", targets: ["SVG"]),
        .library(name: "QuartzAdapter", targets: ["QuartzAdapter"]),
        .library(name: "GraphicsTesting", targets: ["GraphicsTesting"]),

        // Math
        .library(name: "Math", targets: ["Math"]),

        // Structure
        .library(name: "Destructure", targets: ["Destructure"]),
        .library(name: "Algebra", targets: ["Algebra"]),
        .library(name: "DataStructures", targets: ["DataStructures"]),
        .library(name: "Algorithms", targets: ["Algorithms"]),
        // PerformanceTesting
        .library(name: "PerformanceTesting", targets: ["PerformanceTesting"])
    ],
    dependencies: [
        .package(url: "https://github.com/drmohundro/SWXMLHash", from: "4.1.1")
    ],
    targets: [

        // Sources
        .target(name: "Geometry", dependencies: ["Math", "DataStructures"]),
        .target(name: "Path", dependencies: ["Geometry", "Math"]),
        .target(name: "Rendering", dependencies: ["Path"]),
        .target(name: "SVG", dependencies: ["Rendering", "SWXMLHash"]),
        .target(name: "QuartzAdapter", dependencies: ["Rendering"]),
        .target(name: "GraphicsTesting", dependencies: ["QuartzAdapter"]),
        // Math
        .target(name: "Math", dependencies: ["Algebra", "DataStructures"]),
        // Structure
        .target(name: "Destructure"),
        .target(name: "Algebra", dependencies: ["Destructure"]),
        .target(name: "DataStructures", dependencies: ["Destructure", "Algebra", "Algorithms"]),
        .target(name: "Algorithms", dependencies: ["Destructure"]),
        // PerformanceTesting
        .target(name: "PerformanceTesting"),

        // Tests
        .testTarget(name: "GeometryTests", dependencies: ["Geometry"]),
        .testTarget(name: "PathTests", dependencies: ["Path", "Rendering", "GraphicsTesting"]),
        .testTarget(name: "RenderingTests", dependencies: ["Rendering", "GraphicsTesting"]),
        .testTarget(name: "SVGTests", dependencies: ["SVG", "GraphicsTesting"]),
        .testTarget(name: "QuartzAdapterTests", dependencies: ["QuartzAdapter", "GraphicsTesting"]),
        // Math
        .testTarget(name: "MathTests", dependencies: ["Math", "DataStructures"]),
        // Structure
        .testTarget(name: "AlgebraTests", dependencies: ["Algebra"]),
        .testTarget(name: "DataStructuresTests", dependencies: ["DataStructures"]),
        .testTarget(name: "DestructureTests", dependencies: ["Destructure"]),
        .testTarget(name: "AlgorithmsTests", dependencies: ["Algorithms"]),
        // Structure Performance Tests
        .testTarget(
            name: "AlgebraPerformanceTests",
            dependencies: ["Algebra", "PerformanceTesting"]
        ),
        .testTarget(
            name: "DataStructuresPerformanceTests",
            dependencies: ["DataStructures", "PerformanceTesting"]
        ),
        .testTarget(
            name: "AlgorithmsPerformanceTests",
            dependencies: ["Algorithms", "PerformanceTesting"]
        ),
        // PerformanceTesting
        .testTarget(name: "PerformanceTestingTests", dependencies: ["PerformanceTesting"])


    ]
)
