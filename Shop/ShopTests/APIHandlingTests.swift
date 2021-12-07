@testable import Shop
import XCTest

// API Handler tests
//
// The goal of those tests are to check your api handler implementation.
// In this case, we want to see that the API handler is actually calling the network manager.
// Fill up those already created methods.
class APIHandlingTests: XCTestCase {

    let networkManager = MockNetworkManager()
    lazy var apiHandler = APIHandler(networkManager: networkManager)

    func testShouldCallNetworkingManagerWhenFetchShopCalled() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        // TODO: Assert
    }
}
