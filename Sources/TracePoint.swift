import Foundation

public struct TracePoint<Subject>: Error {
    let subject: Subject
    let file: String
    let line: Int
    let function: String
    let date: Date = Date()

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

public extension TracePoint where Subject == Optional<Any> {
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

extension TracePoint: CustomStringConvertible {
    public var description: String {
        "\(formattedTimestamp) | \(line):\(function) | \(subjectString) | \(fileLastPathComponent)"
    }
}

private extension TracePoint {

    var formattedTimestamp: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss.SSSZ"
        return formatter.string(from: date)
    }
    var fileLastPathComponent: String {
        return (file as NSString).lastPathComponent
    }
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