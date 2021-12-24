import Foundation

// TODO: Create the data models
// Check out the API specs on Shop.json 

struct Shop: Codable {
    var company_name: String
    var products: [Product]
}

struct Product: Codable {
    var id: String
    var name: String
    var image: String
    var price_cents: Int
    var currency: String
}
