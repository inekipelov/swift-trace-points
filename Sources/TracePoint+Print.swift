import Foundation

/// Extension providing print-like functionality for TracePoint.
///
/// This extension adds methods that mirror the semantics of Swift's standard `print` function,
/// allowing TracePoint instances to be printed with familiar syntax and options.
///
/// ## Usage
///
/// ```swift
/// let trace = TracePoint("Debug message")
/// 
/// // Basic printing
/// trace.print()
/// 
/// // Print with separator and terminator
/// trace.print(separator: " | ", terminator: "\n\n")
/// 
/// // Print to specific output stream
/// var output = ""
/// trace.print(to: &output)
/// ```
public extension TracePoint {
    
    /// Prints the trace point to the standard output.
    ///
    /// This method mirrors the behavior of Swift's `print()` function,
    /// outputting the trace point's description followed by a newline.
    ///
    /// - Parameters:
    ///   - separator: The string to print between items. Default is a single space.
    ///   - terminator: The string to print after all items. Default is a newline.
    func print(separator: String = " | ", terminator: String = "\n") {
        let description = self.printableOrder.joined(separator: separator)
        Swift.print(description, terminator: terminator)
    }
    
    /// Prints the trace point to the specified output stream.
    ///
    /// This method mirrors the behavior of Swift's `print(_:to:)` function,
    /// allowing output to be directed to any `TextOutputStream`.
    ///
    /// - Parameters:
    ///   - separator: The string to print between items. Default is a single space.
    ///   - terminator: The string to print after all items. Default is a newline.
    ///   - output: An output stream to receive the text representation.
    func print<Target>(
        separator: String = " | ",
        terminator: String = "\n",
        to output: inout Target
    ) where Target: TextOutputStream {
        let description = self.printableOrder.joined(separator: separator)
        Swift.print(description, terminator: terminator, to: &output)
    }
}
