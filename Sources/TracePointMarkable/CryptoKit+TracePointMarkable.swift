/// Extensions for CryptoKit types to add `traced()` methods for convenient trace point creation.

#if canImport(CryptoKit)
import CryptoKit

// MARK: - CryptoKit Type Extensions

/// Extension for CryptoKit types to add tracePoint functionality.
@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
extension SymmetricKey: TracePointMarkable {}

@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
extension SHA256Digest: TracePointMarkable {}

@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
extension SHA384Digest: TracePointMarkable {}

@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
extension SHA512Digest: TracePointMarkable {}

#endif
