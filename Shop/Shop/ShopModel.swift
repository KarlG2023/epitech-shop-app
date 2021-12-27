import Foundation

// TODO: Create the data models
// Check out the API specs on Shop.json 

struct Shop: Codable {
    let company_name: String
    let products: [Product]
}

struct Product: Codable {
    let id: String
    let name: String
    let image: String
    let price_cents: Int
    let currency: String
}
