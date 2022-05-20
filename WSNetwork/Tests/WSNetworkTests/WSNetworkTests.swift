import XCTest
@testable import WSNetwork

final class WSNetworkTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(WSNetwork().text, "Hello, World!")
    }
}
