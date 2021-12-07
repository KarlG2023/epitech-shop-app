import Foundation

protocol DetailPresenterView: AnyObject {
    func apply(product: Product, quantity: Int)
}

class DefaultDetailPresenter: DetailPresenter {
    weak var view: DetailPresenterView?
    var product: Product
    var cacheManager: CacheManaging

    init(cacheManager: CacheManaging, product: Product) {
        self.cacheManager = cacheManager
        self.product = product
    }

    func viewDidLoad() {
        // TODO: Get quantity value from cache
        let quantity = 0

        view?.apply(product: product, quantity: quantity)
    }

    func didTapAddButton() {
        // TODO: Update quantity value
        let quantity = 0

        view?.apply(product: product, quantity: quantity)
    }

    func didTapRemoveButton() {
        // TODO: Update quantity value
        let quantity = 0

        view?.apply(product: product, quantity: quantity)
    }
}

struct ProductQuantity: Codable {
    let quantity: Int
}
