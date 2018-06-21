import XCTest

import MemcachedSwiftTests

var tests = [XCTestCaseEntry]()
tests += MemcachedSwiftTests.allTests()
XCTMain(tests)