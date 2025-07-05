/// Extensions for SwiftUI types to add `traced()` methods for convenient trace point creation.

#if canImport(SwiftUI)
import SwiftUI

// MARK: - SwiftUI Type Extensions

/// Extension for SwiftUI types to add tracePoint functionality.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Color: TracePointMarkable {}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Font: TracePointMarkable {}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension EdgeInsets: TracePointMarkable {}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Angle: TracePointMarkable {}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension UnitPoint: TracePointMarkable {}

#endif
