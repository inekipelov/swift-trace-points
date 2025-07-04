import XCTest
@testable import TracePoints

final class TracePointMarkableTests: XCTestCase {
    
    // MARK: - Test User Defined Types
    
    /// Simple user-defined struct that conforms to TracePointMarkable
    struct TestStruct: TracePointMarkable {
        let name: String
        let value: Int
        
        init(name: String, value: Int) {
            self.name = name
            self.value = value
        }
    }
    
    /// User-defined class that conforms to TracePointMarkable
    class TestClass: TracePointMarkable, CustomStringConvertible {
        let identifier: String
        var counter: Int
        
        init(identifier: String, counter: Int = 0) {
            self.identifier = identifier
            self.counter = counter
        }
        
        func increment() {
            counter += 1
        }
        
        var description: String {
            return "TestClass(identifier: \"\(identifier)\", counter: \(counter))"
        }
    }
    
    /// Complex user-defined type with nested data
    struct ComplexData: TracePointMarkable {
        let id: UUID
        let metadata: [String: Any]
        let timestamp: Date
        
        init(id: UUID = UUID(), metadata: [String: Any] = [:], timestamp: Date = Date()) {
            self.id = id
            self.metadata = metadata
            self.timestamp = timestamp
        }
    }
    
    // MARK: - Basic Protocol Implementation Tests
    
    func testTracePointMarkableProtocolBasicImplementation() {
        let testStruct = TestStruct(name: "TestData", value: 42)
        
        // Test that markTracePoint method exists and can be called
        XCTAssertNoThrow(testStruct.markTracePoint())
    }
    
    func testMarkTracePointWithDefaultParameters() {
        let testClass = TestClass(identifier: "test-123")
        
        // Should work with all default parameters
        XCTAssertNoThrow(testClass.markTracePoint())
    }
    
    func testMarkTracePointWithCustomParameters() {
        let testStruct = TestStruct(name: "Custom", value: 100)
        let customDate = Date(timeIntervalSince1970: 1704067200) // Jan 1, 2024
        
        XCTAssertNoThrow(testStruct.markTracePoint(customDate, "CustomFile.swift", 42, "customMethod()"))
    }
    
    // MARK: - Traced Method Tests
    
    func testMarkTracePointReturnsOriginalValue() {
        let original = TestStruct(name: "Original", value: 123)
        let traced = original.markTracePoint()
        
        XCTAssertEqual(original.name, traced.name)
        XCTAssertEqual(original.value, traced.value)
    }
    
    func testMarkTracePointWithClass() {
        let original = TestClass(identifier: "class-test", counter: 5)
        let traced = original.markTracePoint()
        
        // Should return the same instance for reference types
        XCTAssertTrue(original === traced)
        XCTAssertEqual(original.identifier, traced.identifier)
        XCTAssertEqual(original.counter, traced.counter)
    }
    
    func testMarkTracePointChaining() {
        let testClass = TestClass(identifier: "chain-test")
        
        let result = testClass
            .markTracePoint()
            .markTracePoint()
            .markTracePoint()
        
        XCTAssertTrue(testClass === result)
        XCTAssertEqual(testClass.identifier, result.identifier)
    }
    
    // MARK: - Output Stream Tests
    
    func testMarkTracePointToOutputStream() {
        var output = ""
        let testStruct = TestStruct(name: "OutputTest", value: 999)
        
        testStruct.markTracePoint(to: &output)
        
        XCTAssertFalse(output.isEmpty)
        XCTAssertTrue(output.contains("OutputTest"))
        XCTAssertTrue(output.contains("999"))
        XCTAssertTrue(output.contains("TracePointMarkableTests.swift"))
    }
    
    func testMarkTracePointToOutputStreamReturnsSelf() {
        var output = ""
        let testClass = TestClass(identifier: "output-class", counter: 7)
        
        let result = testClass.markTracePoint(to: &output)
        
        XCTAssertTrue(testClass === result)
        XCTAssertFalse(output.isEmpty)
        XCTAssertTrue(output.contains("output-class"))
        XCTAssertTrue(output.contains("7"))
    }
    
    func testMultipleMarkTracePointsToSameStream() {
        var output = ""
        let struct1 = TestStruct(name: "First", value: 1)
        let struct2 = TestStruct(name: "Second", value: 2)
        let struct3 = TestStruct(name: "Third", value: 3)
        
        struct1.markTracePoint(to: &output)
        struct2.markTracePoint(to: &output)
        struct3.markTracePoint(to: &output)
        
        XCTAssertTrue(output.contains("First"))
        XCTAssertTrue(output.contains("Second"))
        XCTAssertTrue(output.contains("Third"))
        
        let lines = output.components(separatedBy: .newlines).filter { !$0.isEmpty }
        XCTAssertEqual(lines.count, 3)
    }
    
    // MARK: - Complex Data Type Tests
    
    func testComplexDataMarkTracePoint() {
        let complexData = ComplexData(
            id: UUID(),
            metadata: ["key1": "value1", "key2": 42],
            timestamp: Date()
        )
        
        var output = ""
        complexData.markTracePoint(to: &output)
        
        XCTAssertFalse(output.isEmpty)
        XCTAssertTrue(output.contains("ComplexData"))
    }
    
    func testComplexDataMarkTracePointReturnsValue() {
        let original = ComplexData(
            metadata: ["test": "data", "number": 123]
        )
        
        let traced = original.markTracePoint()
        
        XCTAssertEqual(original.id, traced.id)
        XCTAssertEqual(original.timestamp, traced.timestamp)
    }
    
    // MARK: - Custom Parameters Tests
    
    func testMarkTracePointWithAllCustomParameters() {
        let testStruct = TestStruct(name: "CustomParams", value: 555)
        let customDate = Date(timeIntervalSince1970: 1672531200) // Jan 1, 2023
        var output = ""
        
        testStruct.markTracePoint(customDate, "TestFile.swift", 100, "testFunction()", to: &output)
        
        XCTAssertTrue(output.contains("2023"))
        XCTAssertTrue(output.contains("TestFile.swift"))
        XCTAssertTrue(output.contains("100:testFunction()"))
        XCTAssertTrue(output.contains("CustomParams"))
        XCTAssertTrue(output.contains("555"))
    }
    
    func testMarkTracePointWithCustomParametersAndOutputStream() {
        let testClass = TestClass(identifier: "custom-traced")
        let customDate = Date(timeIntervalSince1970: 1640995200) // Jan 1, 2022
        var output = ""
        
        let result = testClass.markTracePoint(customDate, "TracedFile.swift", 200, "tracedFunction()", to: &output)
        
        XCTAssertTrue(testClass === result)
        XCTAssertTrue(output.contains("2022"))
        XCTAssertTrue(output.contains("TracedFile.swift"))
        XCTAssertTrue(output.contains("200:tracedFunction()"))
    }
    
    // MARK: - Method Interaction Tests
    
    func testMarkTracePointAfterMethodCall() {
        let testClass = TestClass(identifier: "method-test", counter: 0)
        
        testClass.increment()
        _ = testClass.markTracePoint()
        testClass.increment()
        
        XCTAssertEqual(testClass.counter, 2)
    }
    
    func testMarkTracePointInMethodChain() {
        let testClass = TestClass(identifier: "chain-method")
        
        testClass.increment()
        let result = testClass.markTracePoint()
        result.increment()
        
        XCTAssertEqual(testClass.counter, 2)
        XCTAssertTrue(testClass === result)
    }
    
    // MARK: - Edge Cases Tests
    
    func testMarkTracePointWithEmptyStringFields() {
        let emptyStruct = TestStruct(name: "", value: 0)
        var output = ""
        
        let result = emptyStruct.markTracePoint(to: &output)
        
        XCTAssertEqual(result.name, "")
        XCTAssertEqual(result.value, 0)
        XCTAssertFalse(output.isEmpty)
    }
    
    func testMarkTracePointWithSpecialCharacters() {
        let specialStruct = TestStruct(name: "Test!@#$%^&*()", value: -999)
        var output = ""
        
        specialStruct.markTracePoint(to: &output)
        
        XCTAssertTrue(output.contains("Test!@#$%^&*()"))
        XCTAssertTrue(output.contains("-999"))
    }

        
    // MARK: - Performance Tests
    
    func testMarkTracePointPerformance() {
        let testStruct = TestStruct(name: "Performance", value: 1)
        
        measure {
            for _ in 0..<1000 {
                _ = testStruct.markTracePoint()
            }
        }
    }
    
    func testMarkTracePointToStreamPerformance() {
        let testStruct = TestStruct(name: "StreamPerf", value: 2)
        var output = ""
        
        measure {
            for _ in 0..<1000 {
                testStruct.markTracePoint(to: &output)
            }
        }
    }
}

// MARK: - Helper Extensions for Testing

extension TracePointMarkableTests {
    
    /// Helper method to validate trace output format
    private func validateTraceOutput(_ output: String, expectedSubject: String? = nil) {
        XCTAssertFalse(output.isEmpty, "Trace output should not be empty")
        
        let components = output.components(separatedBy: " | ")
        XCTAssertGreaterThanOrEqual(components.count, 3, "Trace should have at least 3 components")
        
        // Validate timestamp format
        let timestamp = components[0]
        XCTAssertTrue(timestamp.contains("-"), "Timestamp should contain date separators")
        XCTAssertTrue(timestamp.contains(":"), "Timestamp should contain time separators")
        
        // Validate file name presence
        XCTAssertTrue(output.contains("TracePointMarkableTests.swift"), "Should contain test file name")
        
        // Validate subject if provided
        if let expectedSubject = expectedSubject {
            XCTAssertTrue(output.contains(expectedSubject), "Should contain expected subject: \(expectedSubject)")
        }
    }
    
    /// Helper to capture trace output for analysis
    private func captureTrace<T: TracePointMarkable>(from value: T) -> String {
        var output = ""
        value.markTracePoint(to: &output)
        return output
    }
}