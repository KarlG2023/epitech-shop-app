import Foundation

protocol HomePresenterView: AnyObject {
    func apply(shop: Shop)
    func displayError(message: String)
}

class DefaultHomePresenter: HomePresenter {

    let apiHandler: APIHandling
    weak var view: HomePresenterView?

    init(apiHandler: APIHandling) {
        self.apiHandler = apiHandler
    }

    func viewDidLoad() {
        apiHandler.fetchShop { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(shop):
                    self?.view?.apply(shop: shop)
                case let .failure(error):
                    let message: String
                    switch error {
                    case .noData:
                        message = "No data received"
                    case .error(let apiError):
                        message = apiError.localizedDescription
                    case .malformedData:
                        message = "Malformed data"
                    }
                    self?.view?.displayError(message: message)
                }
            }
        }
    }
}
