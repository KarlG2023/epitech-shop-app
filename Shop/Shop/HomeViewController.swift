import UIKit

protocol HomePresenter {
    var view: HomePresenterView? { get set }
    func viewDidLoad()
}

class HomeViewController: UIViewController {
    var presenter: HomePresenter
    var shop: Shop?
    var dependencies: Dependencies

    var mainView: View {
        view as! View
    }

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        self.presenter = DefaultHomePresenter(apiHandler: dependencies.apiHandler)
        super.init(nibName: nil, bundle: nil)
        self.presenter.view = self
    }

    override func loadView() {
        view = View(dataSource: self, delegate: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // TODO: Set title as the company name
        title = "Shop" // Update this value
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        title = ""
    }
}

extension HomeViewController: HomePresenterView {

    func apply(shop: Shop) {
        self.shop = shop
        // TODO: Set title as the company name
        title = "Shop" // Update this value

        mainView.update()
    }

    func displayError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .destructive, handler: nil)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0 // TODO: Update with right value
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductTableViewCell.self)) as? ProductTableViewCell,
                let shop = shop else {
            fatalError("Couldn't reuse cell with identifier Shop")
        }

        // TODO: Get product at index

        let product: Product = .init()

        cell.apply(product: product)
        return cell
    }

    // TODO: Update method to display the detail view controller on tap
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let shop = shop else {
            fatalError("Should have a shop to call didSelectRowAt")
        }

        // TODO: Get product tapped
        // TODO: Navigate to detail view controller
    }
}

extension HomeViewController {

    class View: UIView {
        let tableView = UITableView(frame: .zero, style: .plain)

        init(
            dataSource: UITableViewDataSource,
            delegate: UITableViewDelegate
        ) {
            super.init(frame: .zero)
            backgroundColor = .green

            addSubview(tableView)

            tableView.delegate = delegate
            tableView.dataSource = dataSource

            tableView.register(
                ProductTableViewCell.self,
                forCellReuseIdentifier: String(describing: ProductTableViewCell.self)
            )
        }

        func update() {
            tableView.reloadData()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func layoutSubviews() {
            super.layoutSubviews()

            tableView.frame = frame
        }
    }
}
