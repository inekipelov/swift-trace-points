/// Extensions for standard Swift types to add `traced()` methods for convenient trace point creation.

// MARK: - Standard Type Extensions

/// Extension for optional types to add tracePoint functionality.
extension Optional: Traceble {}

/// Extension for Bool type to add tracePoint functionality.
extension Bool: Traceble {}

/// Extension for Integer types to add tracePoint functionality.
extension Int: Traceble {}
extension Int8: Traceble {}
extension Int16: Traceble {}
extension Int32: Traceble {}
extension Int64: Traceble {}
extension UInt: Traceble {}
extension UInt8: Traceble {}
extension UInt16: Traceble {}
extension UInt32: Traceble {}
extension UInt64: Traceble {}

/// Extension for Floating Point types to add tracePoint functionality.
extension Float: Traceble {}
extension Double: Traceble {}

#if swift(>=5.3)
@available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *)
extension Float16: Traceble {}
#endif

/// Extension for Character and String types to add tracePoint functionality.
extension Character: Traceble {}
extension Substring: Traceble {}
extension StaticString: Traceble {}

@available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
extension Duration: Traceble {}

/// Extension for String type to add tracePoint functionality.
extension String: Traceble {}

/// Extension for Collection types to add tracePoint functionality.
extension Array: Traceble {}
extension ArraySlice: Traceble {}
extension ContiguousArray: Traceble {}
extension Set: Traceble {}
extension Dictionary: Traceble {}

/// Extension for Range types to add tracePoint functionality.
extension Range: Traceble where Bound: Any {}
extension ClosedRange: Traceble where Bound: Any {}
extension PartialRangeFrom: Traceble where Bound: Any {}
extension PartialRangeUpTo: Traceble where Bound: Any {}
extension PartialRangeThrough: Traceble where Bound: Any {}

/// Extension for Result type to add tracePoint functionality.
extension Result: Traceble where Success: Any, Failure: Error {}
