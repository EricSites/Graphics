# Graphics

![Swift](https://img.shields.io/badge/Swift-5.1-brightgreen.svg)
<!-- [![Build Status](https://travis-ci.org/dn-m/Graphics.svg?branch=master)](https://travis-ci.org/dn-m/Graphics) -->

The `Graphics` package defines structures for graphically representing information, agnostic to the actual drawing API used.

The `Graphics` package contains several modules:

- [`Geometry`](https://github.com/EricSites/Graphics/tree/master/Sources/Geometry)
- [`Path`](https://github.com/EricSites/Graphics/tree/master/Sources/Path)
- [`Rendering`](https://github.com/EricSites/Graphics/tree/master/Sources/Rendering)
- [`SVG`](https://github.com/EricSites/Graphics/tree/master/Sources/SVG)
- [`GraphicsTesting`](https://github.com/EricSites/Graphics/tree/master/Sources/GraphicsTesting)
- [`QuartzAdapter`](https://github.com/EricSites/Graphics/tree/master/Sources/QuartzAdapter)
- [`Destructure`](https://github.com/EricSites/Graphics/tree/master/Sources/Destructure) 
  - Deconstruct `Sequence` types for functional-style recursive algorithms.
- [`Algebra`](https://github.com/EricSites/Graphics/tree/master/Sources/Algebra)
  - Protocols and structures for defining types like `Semigroup`, `Monoid`, and `Group`.
- [`DataStructures`](https://github.com/EricSites/Graphics/tree/master/Sources/DataStructures)
  - Linear data structures (`Stack`, `Queue`, `LinkedList`, `Matrix`, `SortedArray`, and more)
  - Hash-based structures (`OrderedDictionary`, `SortedDictionary`)
  - Tree structures (`Tree`, `BinarySearchTree`, `AVLTree`)
  - Graph structures (`Graph`, `WeightedGraph`, `DirectedGraph`, `WeightedDirectedGraph`)
- [`Algorithms`](https://github.com/EricSites/Graphics/tree/master/Sources/Algorithms)
  - Algorithms for restructuring elements in `Sequence` and `Collection` types, like `subsets` and `combinations`.
- [`Math`](https://github.com/EricSites/Graphics/tree/master/Sources/Math)
  - Helpful mathematical tools for music and graphics
- [`PerformanceTesting`](https://github.com/EricSites/Graphics/tree/master/Sources/PerformanceTesting)
  - **PerformanceTesting** provides tools for checking the [asymptotic complexity](https://en.wikipedia.org/wiki/Asymptotic_computational_complexity) of algorithms and operations over data structures.
  - For example, this is particularly useful for ensuring that an algorithm that you have written which should be perform in constant time (i.e., **O(1)**) isn't [accidentally quadratic](https://accidentallyquadratic.tumblr.com/) (i.e., **O(n<sup>2</sup>)**).

## Getting Started

### Requirements

- Swift 5.1 (default in Xcode 11)
- [Swift Package Manager](https://swift.org/package-manager/)

### Installation

To include the `Structure` package in your own project, add it to the `dependencies` section of your `Package.swift` file:

```Swift
let package = Package(
    name: ...,
    products: [ ... ],
    dependencies: [
        ...,
        .package(url: "https://github.com/EricSites/Graphics", .branch("master"))
    ],
    targets: [ ... ]
)
```

To use a given module in your own project, import the desired module:

```Swift
import Math
import Algebra
import Geometry
import Destructure
import DataStructures
import Algorithms
import SVG
import Path
import Rendering
import QuartzAdapter
import GraphicsTesting
import PerformanceTesting
```

### Development

To contribute to the `Graphics` package, clone the `git` repository:

```sh
git clone https://github.com/EricSites/Graphics && cd Graphics
```

Build the package:

```sh
swift build
```

Run the tests:

```sh
swift test
```

If you use the Xcode IDE, use Swift Package Manager to generate an `.xcodeproj` file:

```sh
swift package generate-xcodeproj
```
