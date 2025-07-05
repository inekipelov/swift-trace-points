/// Extensions for Async/Await types to add `traced()` methods for convenient trace point creation.

#if swift(>=5.5)

// MARK: - Async/Await Type Extensions

/// Extension for Task type to add tracePoint functionality.
@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
extension Task: TracePointMarkable where Success: Any, Failure: Error {}

/// Extension for TaskPriority type to add tracePoint functionality.
@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
extension TaskPriority: TracePointMarkable {}

#endif
