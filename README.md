# TracePoints
[![Swift Version](https://img.shields.io/badge/Swift-5.1+-orange.svg)](https://swift.org/)
[![SPM](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://swift.org/package-manager/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Swift Tests](https://github.com/inekipelov/swift-codable-advance/actions/workflows/swift.yml/badge.svg)](https://github.com/inekipelov/swift-trace-points/actions/workflows/swift.yml)  
[![iOS](https://img.shields.io/badge/iOS-11.0+-blue.svg)](https://developer.apple.com/ios/)
[![macOS](https://img.shields.io/badge/macOS-10.13+-white.svg)](https://developer.apple.com/macos/)
[![tvOS](https://img.shields.io/badge/tvOS-11.0+-black.svg)](https://developer.apple.com/tvos/)
[![watchOS](https://img.shields.io/badge/watchOS-4.0+-orange.svg)](https://developer.apple.com/watchos/)

Lightweight debugging utility for creating structured trace points.

## Usage

```swift
import TracePoints

func foo() {
    // Basic tracing
    "Debug message".markTracePoint()

    // Trace any value
    42.markTracePoint()
    someObject.markTracePoint()

    // Chain tracing
    let result = myFunction().markTracePoint()

    // Custom output
    var output = ""
    "Debug".markTracePoint(to: &output)
}

```

**Output:**
```
2025-07-05 14:32:15.123+0000 | 5:foo() | Debug message | MyFile.swift
2025-07-05 14:32:15.124+0000 | 8:foo() | 42 | MyFile.swift
2025-07-05 14:32:15.125+0000 | 9:foo() | User(name: "John") | MyFile.swift
2025-07-05 14:32:15.126+0000 | 12:foo() | [1, 2, 3] | MyFile.swift
```

## Installation

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/inekipelov/swift-trace-points", from: "0.1.0")
]
```