import Foundation

enum ShopURL {
    static var home = "https://api.npoint.io/c905fd4932fa5fd53b0e"
    static var malformatedHome = "https://api.npoint.io/1d02702b67d713482892"
}

// Excercise: Create a API handler that has a `fetchShop` method.
// The endpoint for the fetchShop API is `ShopURL.home`
protocol APIHandling {
    func fetchShop(completion: ((Result<Shop, NetworkError>) -> Void)?)
}

class APIHandler: APIHandling {

    let networkManager: NetworkManaging

    init(networkManager: NetworkManaging) {
        self.networkManager = networkManager
    }

    func fetchShop(completion: ((Result<Shop, NetworkError>) -> Void)?) {
        guard let url = URL(string: ShopURL.home) else { return }
        
        networkManager.data(from: url, type: Shop.self) { results in
            switch results {
                case .success(let data):
                    completion!(Result<Shop, NetworkError>.success(data))
                case .failure(let error):
                    completion!(Result<Shop, NetworkError>.failure(error))
            }
        }
    }
}
