/// Extensions for Graphics types to add `traced()` methods for convenient trace point creation.

#if canImport(CoreGraphics)
import CoreGraphics

// MARK: - CoreGraphics Type Extensions

extension CGFloat: TracePointMarkable {}
extension CGColor: TracePointMarkable {}
extension CGPoint: TracePointMarkable {}
extension CGSize: TracePointMarkable {}
extension CGRect: TracePointMarkable {}
extension CGVector: TracePointMarkable {}
extension CGAffineTransform: TracePointMarkable {}

#endif
