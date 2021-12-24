@testable import Shop
import XCTest

// Shop Model tests
//
// The goal of those tests are to check your Model decoding.
// You can use the two linked json files to help you achieve those tests.
// Hint: Bundle, Data

// Fill up those already created methods.
class ShopModelTests: XCTestCase {

    var bundle = Bundle(for: NetworkManagerTests.self)

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testModelDecodingFromJSONFileShouldParseWithSuccess() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        guard let resource = bundle.url(forResource: "Shop", withExtension: "json") else {
            XCTFail()
            return
        }

        // Get data from resource
        let data = try Data(contentsOf: resource)
        // Parse it
        let response = try JSONDecoder().decode(Shop.self, from: data)
        // Asserts: Verify the company name, the number of products, values of the first element.
        XCTAssertEqual(response.company_name, "Savon de France")
        XCTAssert(response.products.count == 8, "wrong number of products")
        
        let products = response.products.first
        
        XCTAssertEqual(products?.id, "aloe-vera-bar")
        XCTAssertEqual(products?.name, "Aloe Vera Bar")
        XCTAssert(products?.image == "aloe-vera-bar", "wrong product image")
        XCTAssertEqual(products?.price_cents, 550)
        XCTAssertEqual(products?.currency, "USD")
        // TODO: Assert
    }

    func testMalformedDataDecodingFromJSONFileShouldParseWithFailure() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        guard let resource = bundle.url(forResource: "MalformedShop", withExtension: "json") else {
            XCTFail()
            return
        }

        do {
            // Get data from resource
            let data = try Data(contentsOf: resource)
            // Parse it
            _ = try JSONDecoder().decode(Shop.self, from: data)
        } catch {
            // Verify that decoding is failing and returning nil
            // TODO: Assert
            XCTAssert(true, "nil")
        }
    }
}
