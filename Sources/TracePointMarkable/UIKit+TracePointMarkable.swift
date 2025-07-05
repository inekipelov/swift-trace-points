#if canImport(UIKit)
import UIKit

// MARK: - UIKit Type Extensions

extension UIOffset: TracePointMarkable {}
extension UIEdgeInsets: TracePointMarkable {}
/// Extension for UIKit geometry types to add tracePoint functionality.
extension UIRectEdge: TracePointMarkable {}
extension NSDirectionalEdgeInsets: TracePointMarkable {}

#endif