import Foundation
/// Protocol that enables types to create trace points from their values.
///
/// This protocol provides a unified interface for creating trace points from any conforming type,
/// automatically capturing location information where the method is called.
public protocol Traceble {
    func trace(_ date: Date, _ file: String, _ line: Int, _ function: String)
    func trace<Target>(_ date: Date, _ file: String, _ line: Int, _ function: String, to: inout Target) where Target: TextOutputStream
}

/// Default implementation of Traceble.
public extension Traceble {
    func trace(
        _ date: Date = Date(),
        _ file: String = #file,
        _ line: Int = #line,
        _ function: String = #function
    ) {
        let tracePoint = TracePoint(self, date, file, line, function)
        tracePoint.print()
    }
    
    func trace<Target>(
        _ date: Date = Date(),
        _ file: String = #file,
        _ line: Int = #line,
        _ function: String = #function,
        to output: inout Target
    ) where Target: TextOutputStream {
        let tracePoint = TracePoint(self, date, file, line, function)
        tracePoint.print(to: &output)
    }

    func traced(
        _ date: Date = Date(),
        _ file: String = #file,
        _ line: Int = #line,
        _ function: String = #function
    ) -> Self {
        self.trace(date, file, line, function)
        return self
    }

    func traced<Target>(
        _ date: Date = Date(),
        _ file: String = #file,
        _ line: Int = #line,
        _ function: String = #function,
        to output: inout Target
    ) -> Self where Target: TextOutputStream {
        self.trace(date, file, line, function, to: &output)
        return self
    }
}
