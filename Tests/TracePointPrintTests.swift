import XCTest
@testable import TracePoints

/// Test suite for TracePoint+Print extension functionality.
///
/// This test class verifies the print functionality added to TracePoint,
/// including basic printing, custom separators/terminators, and output stream redirection.
final class TracePointPrintTests: XCTestCase {
    
    /// Custom TextOutputStream implementation for testing output redirection
    struct TestOutputStream: TextOutputStream {
        private(set) var content: String = ""
        
        mutating func write(_ string: String) {
            content += string
        }
    }
    
    // MARK: - Basic Print Tests
    
    /// Tests basic print functionality without crashes
    func testBasicPrintWithoutCrash() {
        let tracePoint = TracePoint("Test message")
        
        // This should not crash
        XCTAssertNoThrow(tracePoint.print())
    }
    
    /// Tests print with custom separator and terminator
    func testPrintWithCustomSeparatorAndTerminator() {
        let tracePoint = TracePoint("Custom test")
        
        // Should not crash with custom parameters
        XCTAssertNoThrow(tracePoint.print(separator: " :: ", terminator: "END\n"))
    }
    
    /// Tests that print returns self for method chaining
    func testPrintReturnsSelf() {
        let tracePoint = TracePoint("Chain test")
        let result = tracePoint.print()
        
        // Should return the same instance for chaining
        XCTAssertTrue(tracePoint.subject == result.subject)
        XCTAssertEqual(tracePoint.line, result.line)
        XCTAssertEqual(tracePoint.file, result.file)
        XCTAssertEqual(tracePoint.function, result.function)
    }
    
    // MARK: - TextOutputStream Integration Tests
    
    /// Tests printing to custom TextOutputStream
    func testPrintToTextOutputStream() {
        let tracePoint = TracePoint("Stream test")
        var output = TestOutputStream()
        
        // Should not crash when printing to custom output stream
        XCTAssertNoThrow(tracePoint.print(to: &output))
        
        // Should have written content to the stream
        XCTAssertFalse(output.content.isEmpty)
        XCTAssertTrue(output.content.contains("Stream test"))
    }
    
    /// Tests printing to TextOutputStream with custom separator
    func testPrintToTextOutputStreamWithCustomSeparator() {
        let tracePoint = TracePoint("Separator test")
        var output = TestOutputStream()
        
        XCTAssertNoThrow(tracePoint.print(separator: " | ", to: &output))
        
        // Should contain the custom separator
        XCTAssertTrue(output.content.contains(" | "))
        XCTAssertTrue(output.content.contains("Separator test"))
    }
    
    /// Tests printing to TextOutputStream with custom terminator
    func testPrintToTextOutputStreamWithCustomTerminator() {
        let tracePoint = TracePoint("Terminator test")
        var output = TestOutputStream()
        
        XCTAssertNoThrow(tracePoint.print(terminator: "END", to: &output))
        
        // Should end with custom terminator
        XCTAssertTrue(output.content.hasSuffix("END"))
        XCTAssertTrue(output.content.contains("Terminator test"))
    }
    
    /// Tests printing to TextOutputStream with both custom separator and terminator
    func testPrintToTextOutputStreamWithCustomSeparatorAndTerminator() {
        let tracePoint = TracePoint("Full custom test")
        var output = TestOutputStream()
        
        XCTAssertNoThrow(tracePoint.print(separator: " ::: ", terminator: " <<END>>", to: &output))
        
        // Should contain both custom separator and terminator
        XCTAssertTrue(output.content.contains(" ::: "))
        XCTAssertTrue(output.content.hasSuffix(" <<END>>"))
        XCTAssertTrue(output.content.contains("Full custom test"))
    }
    
    /// Tests that printing to TextOutputStream returns self for method chaining
    func testPrintToTextOutputStreamReturnsSelf() {
        let tracePoint = TracePoint("Chain stream test")
        var output = TestOutputStream()
        
        let result = tracePoint.print(to: &output)
        
        // Should return the same instance for chaining
        XCTAssertTrue(tracePoint.subject == result.subject)
        XCTAssertEqual(tracePoint.line, result.line)
        XCTAssertEqual(tracePoint.file, result.file)
        XCTAssertEqual(tracePoint.function, result.function)
    }
    
    // MARK: - Integration with Different Subject Types
    
    /// Tests printing with different subject types
    func testPrintWithDifferentSubjectTypes() {
        let stringTrace = TracePoint("String subject")
        let intTrace = TracePoint(42)
        let arrayTrace = TracePoint([1, 2, 3])
        let optionalTrace = TracePoint(nil as String?)
        
        var output = TestOutputStream()
        
        // All should work without crashes
        XCTAssertNoThrow(stringTrace.print(to: &output))
        XCTAssertNoThrow(intTrace.print(to: &output))
        XCTAssertNoThrow(arrayTrace.print(to: &output))
        XCTAssertNoThrow(optionalTrace.print(to: &output))
        
        // Should have content from all prints
        XCTAssertFalse(output.content.isEmpty)
    }
    
    /// Tests that output format includes expected components
    func testOutputFormatContainsExpectedComponents() {
        let tracePoint = TracePoint("Format test")
        var output = TestOutputStream()
        
        tracePoint.print(to: &output)
        
        let content = output.content
        
        // Should contain the subject
        XCTAssertTrue(content.contains("Format test"))
        
        // Should contain function info (line:function format)
        XCTAssertTrue(content.contains(":"))
        
        // Should contain file reference
        XCTAssertTrue(content.contains(".swift"))
        
        // Should contain timestamp (basic check for date format)
        XCTAssertTrue(content.contains("-"))
    }
    
    // MARK: - Edge Cases
    
    /// Tests printing with empty string subject
    func testPrintWithEmptyString() {
        let tracePoint = TracePoint("")
        var output = TestOutputStream()
        
        XCTAssertNoThrow(tracePoint.print(to: &output))
        XCTAssertFalse(output.content.isEmpty)
    }
    
    /// Tests printing with very long subject
    func testPrintWithLongSubject() {
        let longString = String(repeating: "A", count: 1000)
        let tracePoint = TracePoint(longString)
        var output = TestOutputStream()
        
        XCTAssertNoThrow(tracePoint.print(to: &output))
        XCTAssertTrue(output.content.contains(longString))
    }
    
    /// Tests printing with special characters in separator and terminator
    func testPrintWithSpecialCharacters() {
        let tracePoint = TracePoint("Special test")
        var output = TestOutputStream()
        
        XCTAssertNoThrow(tracePoint.print(separator: "🚀", terminator: "💫\n", to: &output))
        XCTAssertTrue(output.content.contains("🚀"))
        XCTAssertTrue(output.content.contains("💫"))
    }
}
