// Do not edit

import Foundation

class Dependencies {

    let networkManager: NetworkManaging = NetworkManager()
    let cacheManager: CacheManaging = CacheManager()
    lazy var apiHandler: APIHandling = APIHandler(networkManager: networkManager)
}
