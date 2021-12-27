import Foundation

// Excercise: Create a caching strategy to save up the quantity of your products
//
// Feel free to use any kind of caching strategy from Apple own frameworks.
// Explain why you went for this implementation and be ready to explain the difference
// between your caching strategy vs others.
protocol CacheManaging {
    func save<T: Codable>(_ value: T?, forKey key: String)
    func value<T: Codable>(forKey key: String, type: T.Type) -> T?
}

class CacheManager: CacheManaging {

    func save<T: Codable>(_ value: T?, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }

    func value<T: Codable>(forKey key: String, type: T.Type) -> T? {
        return UserDefaults.standard.integer(forKey: key) as? T
    }
}

// https://stackoverflow.com/questions/30041765/swift-how-to-store-user-preferences
