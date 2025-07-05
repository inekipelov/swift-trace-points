/// Extensions for Graphics types to add `traced()` methods for convenient trace point creation.

#if canImport(CoreGraphics)
import CoreGraphics

// MARK: - CoreGraphics Type Extensions

extension CGFloat: Traceble {}
extension CGColor: Traceble {}
extension CGPoint: Traceble {}
extension CGSize: Traceble {}
extension CGRect: Traceble {}
extension CGVector: Traceble {}
extension CGAffineTransform: Traceble {}

#endif

#if canImport(UIKit)
import UIKit

// MARK: - UIKit Type Extensions

extension UIOffset: Traceble {}
extension UIEdgeInsets: Traceble {}
/// Extension for UIKit geometry types to add tracePoint functionality.
extension UIRectEdge: Traceble {}
extension NSDirectionalEdgeInsets: Traceble {}

#endif
