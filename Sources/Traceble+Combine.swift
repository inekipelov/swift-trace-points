/// Extensions for Combine types to add `traced()` methods for convenient trace point creation.

#if canImport(Combine)
import Combine

// MARK: - Combine Type Extensions

/// Extension for Combine types to add tracePoint functionality.
@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
extension Just: Traceble {}

@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
extension Empty: Traceble {}

@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
extension Fail: Traceble {}

#endif
