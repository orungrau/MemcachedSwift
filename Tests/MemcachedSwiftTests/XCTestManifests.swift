import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(MemcachedSwiftTests.allTests),
    ]
}
#endif