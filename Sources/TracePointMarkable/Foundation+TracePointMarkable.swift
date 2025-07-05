/// Extensions for Foundation types to add `traced()` methods for convenient trace point creation.

import Foundation

// MARK: - Foundation Type Extensions

extension Decimal: TracePointMarkable {}
/// Extension for Date type to add tracePoint functionality.
extension Date: TracePointMarkable {}
/// Extension for DateInterval type to add tracePoint functionality.
extension DateInterval: TracePointMarkable {}
/// Extension for Calendar type to add tracePoint functionality.
extension Calendar: TracePointMarkable {}
/// Extension for TimeZone type to add tracePoint functionality.
extension TimeZone: TracePointMarkable {}
/// Extension for Locale type to add tracePoint functionality.
extension Locale: TracePointMarkable {}
/// Extension for URL type to add tracePoint functionality.
extension URL: TracePointMarkable {}
/// Extension for URLRequest type to add tracePoint functionality.
extension URLRequest: TracePointMarkable {}
/// Extension for URLComponents type to add tracePoint functionality.
extension URLComponents: TracePointMarkable {}
/// Extension for UUID type to add tracePoint functionality.
extension UUID: TracePointMarkable {}
/// Extension for Data type to add tracePoint functionality.
extension Data: TracePointMarkable {}
/// Extension for NSObject type to add tracePoint functionality.
/// Note: This also provides TracePointMarkable conformance to NSError and other NSObject subclasses.
extension NSObject: TracePointMarkable {}

/// Extension for Error types to add tracePoint functionality.
extension CocoaError: TracePointMarkable {}
extension URLError: TracePointMarkable {}
