import XCTest
@testable import TracePoints

final class TracePointTests: XCTestCase {
    
    // MARK: - Basic Initialization Tests
    
    func testTracePointBasicInitialization() {
        let tracePoint = TracePoint("test message")
        
        XCTAssertEqual(tracePoint.subject, "test message")
        XCTAssertTrue(tracePoint.file.hasSuffix("TracePointTests.swift"))
        XCTAssertEqual(tracePoint.line, 9) // Line where TracePoint was created
        XCTAssertEqual(tracePoint.function, "testTracePointBasicInitialization()")
        XCTAssertTrue(abs(tracePoint.date.timeIntervalSinceNow) < 1.0) // Created recently
    }
    
    func testTracePointWithCustomFileLineFunction() {
        let tracePoint = TracePoint("custom", "CustomFile.swift", 42, "customFunction()")
        
        XCTAssertEqual(tracePoint.subject, "custom")
        XCTAssertEqual(tracePoint.file, "CustomFile.swift")
        XCTAssertEqual(tracePoint.line, 42)
        XCTAssertEqual(tracePoint.function, "customFunction()")
    }
    
    // MARK: - Generic Type Tests
    
    func testTracePointWithInt() {
        let tracePoint = TracePoint(123)
        XCTAssertEqual(tracePoint.subject, 123)
    }
    
    func testTracePointWithOptionalString() {
        let optionalString: String? = "optional value"
        let tracePoint = TracePoint(optionalString)
        XCTAssertEqual(tracePoint.subject, optionalString)
    }
    
    func testTracePointWithNilOptional() {
        let nilString: String? = nil
        let tracePoint = TracePoint(nilString)
        XCTAssertNil(tracePoint.subject)
    }
    
    func testTracePointWithComplexType() {
        struct TestStruct {
            let value: String
        }
        let testStruct = TestStruct(value: "test")
        let tracePoint = TracePoint(testStruct)
        XCTAssertEqual(tracePoint.subject.value, "test")
    }
    
    // MARK: - Optional Extension Tests
    
    func testOptionalExtensionWithValue() {
        let tracePoint = TracePoint("some value")
        XCTAssertEqual(tracePoint.subject, "some value")
    }
    
    func testOptionalExtensionWithNil() {
        let tracePoint = TracePoint(nil)
        XCTAssertNil(tracePoint.subject)
    }
    
    func testOptionalExtensionWithCustomParameters() {
        let tracePoint = TracePoint("test", "TestFile.swift", 100, "testFunction()")
        
        XCTAssertEqual(tracePoint.subject, "test")
        XCTAssertEqual(tracePoint.file, "TestFile.swift")
        XCTAssertEqual(tracePoint.line, 100)
        XCTAssertEqual(tracePoint.function, "testFunction()")
    }
    
    // MARK: - CustomStringConvertible Tests
    
    func testDescriptionFormat() {
        let tracePoint = TracePoint("test message", "TestFile.swift", 50, "testMethod()")
        let description = tracePoint.description
        
        // Check that description contains all expected components
        XCTAssertTrue(description.contains("50:testMethod()"))
        XCTAssertTrue(description.contains("test message"))
        XCTAssertTrue(description.contains("TestFile.swift"))
        
        // Check timestamp format (YYYY-MM-dd HH:mm:ss.SSSZ)
        let timestampRegex = try! NSRegularExpression(pattern: "\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}\\.\\d{3}[+-]\\d{4}")
        let range = NSRange(location: 0, length: description.count)
        XCTAssertTrue(timestampRegex.firstMatch(in: description, options: [], range: range) != nil)
    }
    
    func testDescriptionWithEmptySubject() {
        let tracePoint = TracePoint(nil, "TestFile.swift", 10, "emptyTest()")
        let description = tracePoint.description
        
        // Should handle empty subject gracefully
        XCTAssertTrue(description.contains("10:emptyTest()"))
        XCTAssertTrue(description.contains("TestFile.swift"))
        XCTAssertFalse(description.contains("nil")) // Should be empty string, not "nil"
    }
    
    func testDescriptionComponents() {
        let tracePoint = TracePoint(42, "/path/to/SomeFile.swift", 123, "someFunction()")
        let description = tracePoint.description
        
        let components = description.components(separatedBy: " | ")
        XCTAssertEqual(components.count, 4)
        
        // Timestamp
        XCTAssertTrue(components[0].range(of: "\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}\\.\\d{3}[+-]\\d{4}", options: .regularExpression) != nil)
        
        // Line:Function
        XCTAssertEqual(components[1], "123:someFunction()")
        
        // Subject
        XCTAssertEqual(components[2], "42")
        
        // File (last path component)
        XCTAssertEqual(components[3], "SomeFile.swift")
    }
    
    // MARK: - Error Protocol Conformance Tests
    
    func testTracePointAsError() {
        let tracePoint = TracePoint("error message")
        let error: Error = tracePoint
        
        // Should be able to cast back
        XCTAssertTrue(error is TracePoint<String>)
        
        if let castedTracePoint = error as? TracePoint<String> {
            XCTAssertEqual(castedTracePoint.subject, "error message")
        } else {
            XCTFail("Failed to cast Error back to TracePoint")
        }
    }
    
    // MARK: - Edge Cases Tests
    
    func testTracePointWithEmptyString() {
        let tracePoint = TracePoint("")
        XCTAssertEqual(tracePoint.subject, "")
        XCTAssertTrue(tracePoint.description.contains(" |  | ")) // Empty subject appears as empty between pipes
    }
    
    func testTracePointWithVeryLongSubject() {
        let longString = String(repeating: "A", count: 1000)
        let tracePoint = TracePoint(longString)
        XCTAssertEqual(tracePoint.subject, longString)
        XCTAssertTrue(tracePoint.description.contains(longString))
    }
    
    func testMultipleTracePointsHaveDifferentTimestamps() {
        let tracePoint1 = TracePoint("first")
        Thread.sleep(forTimeInterval: 0.001) // Small delay
        let tracePoint2 = TracePoint("second")
        
        XCTAssertNotEqual(tracePoint1.date, tracePoint2.date)
        XCTAssertTrue(tracePoint1.date < tracePoint2.date)
    }
    
    // MARK: - Date Formatting Tests
    
    func testDateFormatterConsistency() {
        let tracePoint = TracePoint("test")
        let description1 = tracePoint.description
        let description2 = tracePoint.description
        
        // Description should be consistent for same TracePoint
        XCTAssertEqual(description1, description2)
    }
}