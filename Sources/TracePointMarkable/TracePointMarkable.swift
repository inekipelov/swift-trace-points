import Foundation
/// Protocol that enables types to create trace points from their values.
///
/// This protocol provides a unified interface for creating trace points from any conforming type,
/// automatically capturing location information where the method is called.
public protocol TracePointMarkable {}

/// Default implementation of TracePointMarkable.
public extension TracePointMarkable {
    
    @discardableResult
    func markTracePoint(
        _ date: Date = Date(),
        _ file: String = #file,
        _ line: Int = #line,
        _ function: String = #function
    ) -> Self {
        let tracePoint = TracePoint(self, date, file, line, function)
        tracePoint.print()
        return self
    }

    @discardableResult
    func markTracePoint<Target>(
        _ date: Date = Date(),
        _ file: String = #file,
        _ line: Int = #line,
        _ function: String = #function,
        to output: inout Target
    ) -> Self where Target: TextOutputStream {
        let tracePoint = TracePoint(self, date, file, line, function)
        tracePoint.print(to: &output)
        return self
    }
}
