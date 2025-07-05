/// Extensions for standard Swift types to add `traced()` methods for convenient trace point creation.

// MARK: - Standard Type Extensions

/// Extension for optional types to add tracePoint functionality.
extension Optional: TracePointMarkable {}

/// Extension for Bool type to add tracePoint functionality.
extension Bool: TracePointMarkable {}

/// Extension for Integer types to add tracePoint functionality.
extension Int: TracePointMarkable {}
extension Int8: TracePointMarkable {}
extension Int16: TracePointMarkable {}
extension Int32: TracePointMarkable {}
extension Int64: TracePointMarkable {}
extension UInt: TracePointMarkable {}
extension UInt8: TracePointMarkable {}
extension UInt16: TracePointMarkable {}
extension UInt32: TracePointMarkable {}
extension UInt64: TracePointMarkable {}

/// Extension for Floating Point types to add tracePoint functionality.
extension Float: TracePointMarkable {}
extension Double: TracePointMarkable {}

#if swift(>=5.3)
@available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *)
extension Float16: TracePointMarkable {}
#endif

/// Extension for Character and String types to add tracePoint functionality.
extension Character: TracePointMarkable {}
extension Substring: TracePointMarkable {}
extension StaticString: TracePointMarkable {}

@available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
extension Duration: TracePointMarkable {}

/// Extension for String type to add tracePoint functionality.
extension String: TracePointMarkable {}

/// Extension for Collection types to add tracePoint functionality.
extension Array: TracePointMarkable {}
extension ArraySlice: TracePointMarkable {}
extension ContiguousArray: TracePointMarkable {}
extension Set: TracePointMarkable {}
extension Dictionary: TracePointMarkable {}

/// Extension for Range types to add tracePoint functionality.
extension Range: TracePointMarkable where Bound: Any {}
extension ClosedRange: TracePointMarkable where Bound: Any {}
extension PartialRangeFrom: TracePointMarkable where Bound: Any {}
extension PartialRangeUpTo: TracePointMarkable where Bound: Any {}
extension PartialRangeThrough: TracePointMarkable where Bound: Any {}

/// Extension for Result type to add tracePoint functionality.
extension Result: TracePointMarkable where Success: Any, Failure: Error {}
