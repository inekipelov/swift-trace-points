/// Extensions for Foundation types to add `traced()` methods for convenient trace point creation.

import Foundation

// MARK: - Foundation Type Extensions

extension Decimal: Traceble {}
/// Extension for Date type to add tracePoint functionality.
extension Date: Traceble {}
/// Extension for DateInterval type to add tracePoint functionality.
extension DateInterval: Traceble {}
/// Extension for Calendar type to add tracePoint functionality.
extension Calendar: Traceble {}
/// Extension for TimeZone type to add tracePoint functionality.
extension TimeZone: Traceble {}
/// Extension for Locale type to add tracePoint functionality.
extension Locale: Traceble {}
/// Extension for URL type to add tracePoint functionality.
extension URL: Traceble {}
/// Extension for URLRequest type to add tracePoint functionality.
extension URLRequest: Traceble {}
/// Extension for URLComponents type to add tracePoint functionality.
extension URLComponents: Traceble {}
/// Extension for UUID type to add tracePoint functionality.
extension UUID: Traceble {}
/// Extension for Data type to add tracePoint functionality.
extension Data: Traceble {}
/// Extension for NSObject type to add tracePoint functionality.
/// Note: This also provides Traceble conformance to NSError and other NSObject subclasses.
extension NSObject: Traceble {}

/// Extension for Error types to add tracePoint functionality.
extension CocoaError: Traceble {}
extension URLError: Traceble {}
