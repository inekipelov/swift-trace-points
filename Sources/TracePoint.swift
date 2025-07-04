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
    
    /// The file path where the trace point was created.
    let file: String
    
    /// The line number where the trace point was created.
    let line: Int
    
    /// The function name where the trace point was created.
    let function: String
    
    /// The timestamp when the trace point was created.
    let date: Date = Date()

    /// Creates a new trace point with the specified subject.
    ///
    /// - Parameters:
    ///   - subject: The subject to trace.
    ///   - file: The file path (automatically filled with `#file`).
    ///   - line: The line number (automatically filled with `#line`).
    ///   - function: The function name (automatically filled with `#function`).
    init(
        _ subject: Subject,
        _ file: String = #file,
        _ line: Int = #line,
        _ function: String = #function
    ) {
        self.subject = subject
        self.line = line
        self.file = file
        self.function = function
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
        _ file: String = #file,
        _ line: Int = #line,
        _ function: String = #function
    ) {
        self.subject = subject
        self.line = line
        self.file = file
        self.function = function
    }
}

/// Conformance to `CustomStringConvertible` for readable trace point output.
///
/// The string representation includes:
/// - Formatted timestamp
/// - Line number and function name
/// - Subject description
/// - File name (last path component)
///
/// ## Output Format
///
/// ```
/// 2025-07-04 10:30:45.123+0000 | 42:myFunction() | Debug message | MyFile.swift
/// ```
extension TracePoint: CustomStringConvertible {
    /// A formatted string representation of the trace point.
    ///
    /// The description includes the timestamp, location information, subject,
    /// and filename in a readable format suitable for logging and debugging.
    public var description: String {
        "\(formattedTimestamp) | \(line):\(function) | \(subjectString) | \(fileLastPathComponent)"
    }
}

/// Private extension containing utility methods for string formatting.
private extension TracePoint {

    /// Formats the trace point's timestamp using ISO 8601 format.
    ///
    /// - Returns: A formatted timestamp string in the format "YYYY-MM-dd HH:mm:ss.SSSZ".
    var formattedTimestamp: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss.SSSZ"
        return formatter.string(from: date)
    }
    
    /// Extracts the last path component from the file path.
    ///
    /// - Returns: The filename without the full path (e.g., "TracePoint.swift" instead of "/path/to/TracePoint.swift").
    var fileLastPathComponent: String {
        return (file as NSString).lastPathComponent
    }
    
    /// Converts the subject to a string representation, handling optional types.
    ///
    /// For optional types, this method unwraps the value if present, or returns an empty string if nil.
    /// For non-optional types, it returns the string representation of the subject.
    ///
    /// - Returns: A string representation of the subject.
    var subjectString: String {
        let mirror = Mirror(reflecting: subject)
        if mirror.displayStyle == .optional {
            if let unwrapped = mirror.children.first?.value {
                return "\(unwrapped)"
            } else {
                return ""
            }
        } else {
            return "\(subject)"
        }
    }
}