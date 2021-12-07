@testable import Shop
import Foundation

// Mocks - Do not edit

class MockNetworkManager: NetworkManaging {
    var dataURL: URL!
    var dataCallCount = 0

    init() {}

    func data<T>(from url: URL, type: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        dataURL = url
        dataCallCount += 1
    }
}

class MockCacheManager: CacheManaging {
    var saveCallCount = 0
    var valueCallCount = 0

    func save<T: Codable>(_ value: T, forKey key: String) {
        saveCallCount += 1
    }

    func value<T: Codable>(forKey key: String, type: T.Type) -> T? {
        valueCallCount += 1
        return nil
    }
}

class MockAPIHandler: APIHandling {
    var fetchShopCallCount = 0
    var fetchShopCompletion: ((Result<Shop, NetworkError>) -> Void)?

    func fetchShop(completion: ((Result<Shop, NetworkError>) -> Void)?) {
        fetchShopCallCount += 1
        fetchShopCompletion = completion
    }
}


class MockHomeViewController: HomePresenterView {
    var applyCallCount = 0
    var applyShop: Shop?

    var displayErrorCallCount = 0
    var displayErrorMessage: String?

    func apply(shop: Shop) {
        applyShop = shop
        applyCallCount += 1
    }

    func displayError(message: String) {
        displayErrorMessage = message
        displayErrorCallCount += 1
    }
}

class MockDetailViewController: DetailPresenterView {
    var applyCallCount = 0
    var applyProduct: Product?
    var applyQuantity: Int = 0

    func apply(product: Product, quantity: Int) {
        applyProduct = product
        applyQuantity = quantity
        applyCallCount += 1
    }
}

class MockData: Codable {
    
}
