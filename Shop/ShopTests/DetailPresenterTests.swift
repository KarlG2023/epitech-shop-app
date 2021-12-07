@testable import Shop
import XCTest

// Detail Presenter tests
//
// The goal of those tests are to check your Home presenter implementation.
// Those tests will checks the behavior of the presenter and its interaction with the cache.
//
// Hint: DispatchQueue.main, Testing with expectation.
// Fill up those already created methods.
class DetailPresenterTests: XCTestCase {

    var presenter: DetailPresenter!
    var view = MockDetailViewController()
    var cacheManager = MockCacheManager()
    var product = Product(id: "test", name: "Soap", currency: "USD", priceCents: 550, image: "test")

    override func setUpWithError() throws {
        presenter = DefaultDetailPresenter(cacheManager: cacheManager, product: product)
        presenter.view = view
    }

    func testViewDidLoad_applyProduct() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        // TODO: Assert
    }

    func testViewDidLoad_checkCacheForQuantity() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        // TODO: Assert
    }

    func testDidTapAddButton_callSaveCacheManager() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        // TODO: Assert
    }

    func testDidTapAddButton_applyProductAndQuantity() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        // TODO: Assert
    }

    func testDidTapRemoveButton_callSaveCacheManager() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        // Assert
    }

    func testDidTapRemoveButton_applyProductAndQuantity() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        // TODO: Assert
    }
}
