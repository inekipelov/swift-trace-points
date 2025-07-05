import XCTest
@testable import TracePoints

final class TracePointTests: XCTestCase {
    
    // MARK: - Basic Initialization Tests
    
    func testTracePointWithStringSubject() {
        let message = "Test message"
        let tracePoint = TracePoint(message)
        
        XCTAssertEqual(tracePoint.subject, message)
        XCTAssertNotNil(tracePoint.date)
        XCTAssertTrue(tracePoint.file.contains("TracePointTests.swift"))
        XCTAssertEqual(tracePoint.line, 10) // Line where TracePoint was created
        XCTAssertTrue(tracePoint.function.contains("testTracePointWithStringSubject"))
    }
    
    func testTracePointWithIntSubject() {
        let number = 42
        let tracePoint = TracePoint(number)
        
        XCTAssertEqual(tracePoint.subject, number)
        XCTAssertNotNil(tracePoint.date)
        XCTAssertTrue(tracePoint.file.contains("TracePointTests.swift"))
    }
    
    func testTracePointWithCustomType() {
        struct TestStruct {
            let value: String
        }
        
        let testStruct = TestStruct(value: "test")
        let tracePoint = TracePoint(testStruct)
        
        XCTAssertEqual(tracePoint.subject.value, testStruct.value)
        XCTAssertNotNil(tracePoint.date)
    }
    
    // MARK: - Optional Subject Tests
    
    func testTracePointWithOptionalNilSubject() {
        let tracePoint = TracePoint()
        
        XCTAssertNil(tracePoint.subject)
        XCTAssertNotNil(tracePoint.date)
        XCTAssertTrue(tracePoint.file.contains("TracePointTests.swift"))
    }
    
    func testTracePointWithOptionalNonNilSubject() {
        let value: String? = "Optional value"
        let tracePoint = TracePoint(value)
        
        XCTAssertEqual(tracePoint.subject, value)
        XCTAssertNotNil(tracePoint.date)
    }
    
    func testTracePointWithExplicitNil() {
        let nilValue: String? = nil
        let tracePoint = TracePoint(nilValue)
        
        XCTAssertNil(tracePoint.subject)
        XCTAssertNotNil(tracePoint.date)
    }
    
    // MARK: - String Representation Tests
    
    func testDescriptionContainsAllComponents() {
        let message = "Debug message"
        let tracePoint = TracePoint(message)
        let description = tracePoint.description
        
        // Should contain timestamp
        XCTAssertTrue(description.contains(":"))
        XCTAssertTrue(description.contains("-"))
        
        // Should contain line and function
        XCTAssertTrue(description.contains("\(tracePoint.line):"))
        XCTAssertTrue(description.contains("testDescriptionContainsAllComponents"))
        
        // Should contain subject
        XCTAssertTrue(description.contains(message))
        
        // Should contain file name
        XCTAssertTrue(description.contains("TracePointTests.swift"))
        
        // Should use pipe separator
        XCTAssertTrue(description.contains(" | "))
    }
    
    func testPrintableTimestamp() {
        let fixedDate = Date(timeIntervalSince1970: 1757638245.123) // July 5, 2025 10:30:45.123 UTC
        let tracePoint = TracePoint("test", fixedDate)
        
        let timestamp = tracePoint.printableTimestamp
        XCTAssertTrue(timestamp.contains("2025"))
        XCTAssertTrue(timestamp.contains(":"))
        XCTAssertTrue(timestamp.contains("."))
    }
    
    func testPrintableLineFunction() {
        let tracePoint = TracePoint("test")
        let lineFunction = tracePoint.printableLineFunction
        
        XCTAssertTrue(lineFunction.contains(":"))
        XCTAssertTrue(lineFunction.contains("testPrintableLineFunction"))
        XCTAssertTrue(lineFunction.contains("\(tracePoint.line)"))
    }
    
    func testPrintableFile() {
        let tracePoint = TracePoint("test")
        let fileName = tracePoint.printableFile
        
        XCTAssertEqual(fileName, "TracePointTests.swift")
        XCTAssertFalse(fileName.contains("/"))
    }
    
    func testPrintableSubjectWithNonOptional() {
        let tracePoint = TracePoint("test message")
        let subject = tracePoint.printableSubject
        
        XCTAssertEqual(subject, "test message")
    }
    
    func testPrintableSubjectWithOptionalNil() {
        let tracePoint = TracePoint()
        let subject = tracePoint.printableSubject
        
        XCTAssertNil(subject)
    }
    
    func testPrintableSubjectWithOptionalValue() {
        let value: String? = "optional value"
        let tracePoint = TracePoint(value)
        let subject = tracePoint.printableSubject
        
        XCTAssertEqual(subject, "optional value")
    }
    
    func testPrintableOrderExcludesNilSubject() {
        let tracePoint = TracePoint()
        let printableOrder = tracePoint.printableOrder
        
        // Should have 3 components (timestamp, line:function, file) but not subject
        XCTAssertEqual(printableOrder.count, 3)
        XCTAssertFalse(printableOrder.joined().isEmpty)
    }
    
    func testPrintableOrderIncludesNonNilSubject() {
        let tracePoint = TracePoint("test")
        let printableOrder = tracePoint.printableOrder
        
        // Should have 4 components (timestamp, line:function, subject, file)
        XCTAssertEqual(printableOrder.count, 4)
        XCTAssertTrue(printableOrder.contains("test"))
    }
    
    // MARK: - Error Protocol Tests
    
    func testTracePointAsError() {
        let errorMessage = "Something went wrong"
        
        do {
            throw TracePoint(errorMessage)
        } catch let traceError as TracePoint<String> {
            XCTAssertEqual(traceError.subject, errorMessage)
            XCTAssertTrue(traceError.file.contains("TracePointTests.swift"))
        } catch {
            XCTFail("Should catch TracePoint error")
        }
    }
    
    func testTracePointErrorDescription() {
        let errorMessage = "Error occurred"
        let traceError = TracePoint(errorMessage)
        
        // As an Error, it should have a description
        let errorDescription = String(describing: traceError)
        XCTAssertTrue(errorDescription.contains(errorMessage))
        XCTAssertTrue(errorDescription.contains("TracePointTests.swift"))
    }
    
    // MARK: - Edge Cases
    
    func testTracePointWithEmptyString() {
        let emptyString = ""
        let tracePoint = TracePoint(emptyString)
        
        XCTAssertEqual(tracePoint.subject, emptyString)
        let description = tracePoint.description
        XCTAssertFalse(description.isEmpty)
        // Should still contain other components even with empty subject
        XCTAssertTrue(description.contains("TracePointTests.swift"))
    }
    
    func testTracePointWithComplexType() {
        struct ComplexType {
            let array: [String]
            let dictionary: [String: Int]
            let optional: String?
        }
        
        let complex = ComplexType(
            array: ["a", "b", "c"],
            dictionary: ["key": 123],
            optional: "value"
        )
        let tracePoint = TracePoint(complex)
        
        XCTAssertEqual(tracePoint.subject.array, complex.array)
        XCTAssertEqual(tracePoint.subject.dictionary, complex.dictionary)
        XCTAssertEqual(tracePoint.subject.optional, complex.optional)
    }
    
    func testMultipleTracePointsHaveDifferentTimestamps() {
        let tracePoint1 = TracePoint("first")
        Thread.sleep(forTimeInterval: 0.001) // Small delay
        let tracePoint2 = TracePoint("second")
        
        XCTAssertNotEqual(tracePoint1.date.timeIntervalSince1970, 
                         tracePoint2.date.timeIntervalSince1970)
    }
    
    func testTracePointCapturesCorrectLineNumbers() {
        let tracePoint1 = TracePoint("line 1")
        let line1 = tracePoint1.line
        let tracePoint2 = TracePoint("line 2")
        let line2 = tracePoint2.line
        
        XCTAssertGreaterThan(line1, 0)
        XCTAssertGreaterThan(line2, 0)
        XCTAssertEqual(line2, line1 + 2) // Should be 2 lines apart
    }
}