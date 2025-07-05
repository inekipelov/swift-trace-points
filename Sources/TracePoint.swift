import Foundation

/// A trace point structure for debugging and logging purposes.
///
/// `TracePoint` captures contextual information about where it was created, including
/// the subject being traced, file location, line number, function name, and timestamp.
/// It conforms to the `Error` protocol, making it useful for error handling and debugging.
///
/// ## Usage
///
/// ```swift
/// // Basic usage with any subject
/// let tracePoint = TracePoint("Debug message")
/// print(tracePoint)
///
/// // With optional subject
/// let optionalTrace = TracePoint(someOptionalValue)
/// 
/// // Can be thrown as an error
/// throw TracePoint("Something went wrong")
/// ```
///
/// - Note: The trace point automatically captures file, line, and function information
///   using Swift's `#file`, `#line`, and `#function` literals.
public struct TracePoint<Subject>: Error {
    /// The subject being traced. Can be any type.
    let subject: Subject

    /// The timestamp when the trace point was created.
    let date: Date
    
    /// The file path where the trace point was created.
    let file: String
    
    /// The line number where the trace point was created.
    let line: Int
    
    /// The function name where the trace point was created.
    let function: String

    /// An optional label for the trace point, providing additional context.
    let label: String?

    /// Creates a new trace point with the specified subject.
    ///
    /// - Parameters:
    ///   - subject: The subject to trace.
    ///   - file: The file path (automatically filled with `#file`).
    ///   - line: The line number (automatically filled with `#line`).
    ///   - function: The function name (automatically filled with `#function`).
    init(
        _ subject: Subject,
        _ date: Date = Date(),
        _ file: String = #file,
        _ line: Int = #line,
        _ function: String = #function,
        label: String? = nil
    ) {
        self.subject = subject
        self.date = date
        self.line = line
        self.file = file
        self.function = function
        self.label = label
    }
}

/// Extension for `TracePoint` when the subject is an optional type.
///
/// This extension provides a convenient initializer for creating trace points
/// with optional subjects, allowing for cleaner syntax when tracing optional values.
///
/// ## Example
///
/// ```swift
/// let optionalValue: String? = nil
/// let trace = TracePoint(optionalValue)  // Uses this extension
/// 
/// // Or with no subject at all
/// let emptyTrace = TracePoint()
/// ```
public extension TracePoint where Subject == Optional<Any> {
    /// Creates a trace point with an optional subject.
    ///
    /// - Parameters:
    ///   - subject: The optional subject to trace. Defaults to `nil`.
    ///   - file: The file path (automatically filled with `#file`).
    ///   - line: The line number (automatically filled with `#line`).
    ///   - function: The function name (automatically filled with `#function`).
    init(
        _ subject: Any? = nil,
        _ date: Date = Date(),
        _ file: String = #file,
        _ line: Int = #line,
        _ function: String = #function,
        label: String? = nil
    ) {
        self.subject = subject
        self.date = date
        self.line = line
        self.file = file
        self.function = function
        self.label = label
    }
}

/// Conformance to `CustomStringConvertible` for readable trace point output.
///
/// The string representation includes:
/// - Formatted timestamp
/// - Line number and function name
/// - Subject description
/// - File name (last path component)
/// - Optional label if provided
///
/// ## Output Format
///
/// ```
/// 2025-07-04 10:30:45.123+0000 | 42:myFunction() | message = Debug message | MyFile.swift
/// ```
extension TracePoint: CustomStringConvertible {
    /// A formatted string representation of the trace point.
    ///
    /// The description includes the timestamp, location information, subject,
    /// and filename in a readable format suitable for logging and debugging.
    public var description: String {
        printableOrder.joined(separator: " | ")
    }
}

/// Extension containing utility methods for string formatting.
extension TracePoint {

    /// Returns an ordered array of formatted string components for the trace point.
    ///
    /// This property provides the default ordering of trace point components used in
    /// the string representation. The order is designed to provide the most useful
    /// information first for debugging and logging purposes.
    ///
    /// ## Component Order
    ///
    /// 1. **Timestamp** - When the trace point was created
    /// 2. **Line and Function** - Where in the code it was created
    /// 3. **Subject** - The traced value or message, or skip if nil
    /// 4. **File** - Which source file contains the trace point
    ///
    /// ## Example Output
    ///
    /// ```swift
    /// let trace = TracePoint("Debug message")
    /// let components = trace.printableOrder
    /// // components contains:
    /// // ["2025-07-04 10:30:45.123+0000", "42:myFunction()", "Debug message", "MyFile.swift"]
    /// ```
    ///
    /// - Returns: An array of formatted string components in display order.
    var printableOrder: [String] {
        [
            printableTimestamp,
            printableLineFunction,
            printableSubject,
            printableFile
        ].compactMap { $0 }
    }

    /// Formats the trace point's timestamp using ISO 8601 format.
    ///
    /// - Returns: A formatted timestamp string in the format "YYYY-MM-dd HH:mm:ss.SSSZ".
    var printableTimestamp: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss.SSSZ"
        return formatter.string(from: date)
    }

    /// Formats the line number and function name for display.
    ///
    /// Creates a string representation combining the line number and function name
    /// in the format "line:function", which is commonly used in debugging output.
    ///
    /// ## Example Output
    ///
    /// ```
    /// "42:myFunction()"
    /// "125:init(subject:file:line:function:)"
    /// "87:description"
    /// ```
    ///
    /// - Returns: A formatted string containing the line number and function name.
    var printableLineFunction: String {
        return "\(line):\(function)"
    }
    
    /// Extracts the last path component from the file path.
    ///
    /// - Returns: The filename without the full path (e.g., "TracePoint.swift" instead of "/path/to/TracePoint.swift").
    var printableFile: String {
        return (file as NSString).lastPathComponent
    }
    
    /// Converts the subject to a string representation, handling optional types.
    ///
    /// For optional types, this method unwraps the value if present, or returns an empty string if nil.
    /// For non-optional types, it returns the string representation of the subject.
    ///
    /// - Returns: A string representation of the subject.
    var printableSubject: String? {
        let labelPart = label.map { "\($0) = " } ?? ""
        let mirror = Mirror(reflecting: subject)
        if mirror.displayStyle == .optional {
            if let unwrapped = mirror.children.first?.value {
                return "\(labelPart)\(unwrapped)"
            } else {
                return nil
            }
        } else {
            return "\(labelPart)\(subject)"
        }
    }
}