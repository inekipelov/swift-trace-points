/// Extensions for Error types to add `traced()` methods for convenient trace point creation.

// MARK: - Swift Standard Error Types

/// Extension for Swift standard error types to add tracePoint functionality.
extension DecodingError: Traceble {}
extension EncodingError: Traceble {}

// MARK: - Framework Error Types

#if canImport(CoreData)
import CoreData

/// Extension for Core Data error types to add tracePoint functionality.
// Note: Core Data errors are typically handled through NSError with specific domains
#endif

#if canImport(CloudKit)
import CloudKit

/// Extension for CloudKit error types to add tracePoint functionality.
extension CKError: Traceble {}
#endif

#if canImport(Network)
import Network

/// Extension for Network framework error types to add tracePoint functionality.
@available(macOS 10.14, iOS 12.0, watchOS 5.0, tvOS 12.0, *)
extension NWError: Traceble {}
#endif

#if canImport(AVFoundation)
import AVFoundation

/// Extension for AVFoundation error types to add tracePoint functionality.
extension AVError: Traceble {}
#endif

#if canImport(StoreKit)
import StoreKit

/// Extension for StoreKit error types to add tracePoint functionality.
extension SKError: Traceble {}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension StoreKitError: Traceble {}
#endif

#if canImport(GameKit)
import GameKit

/// Extension for GameKit error types to add tracePoint functionality.
extension GKError: Traceble {}
#endif

#if canImport(MapKit)
import MapKit

/// Extension for MapKit error types to add tracePoint functionality.
extension MKError: Traceble {}
#endif

#if canImport(EventKit)
import EventKit

/// Extension for EventKit error types to add tracePoint functionality.
extension EKError: Traceble {}
#endif

#if canImport(Contacts)
import Contacts

/// Extension for Contacts error types to add tracePoint functionality.
extension CNError: Traceble {}
#endif

#if canImport(Photos)
import Photos

/// Extension for Photos error types to add tracePoint functionality.
extension PHPhotosError: Traceble {}
#endif

#if canImport(HealthKit)
import HealthKit

/// Extension for HealthKit error types to add tracePoint functionality.
@available(macOS 13.0, iOS 8.0, watchOS 2.0, *)
extension HKError: Traceble {}
#endif

#if canImport(WatchConnectivity)
import WatchConnectivity

/// Extension for WatchConnectivity error types to add tracePoint functionality.
extension WCError: Traceble {}
#endif

#if canImport(AuthenticationServices)
import AuthenticationServices

/// Extension for AuthenticationServices error types to add tracePoint functionality.
@available(iOS 12.0, macOS 10.15, tvOS 16.0, watchOS 6.2, *)
extension ASAuthorizationError: Traceble {}
#endif
