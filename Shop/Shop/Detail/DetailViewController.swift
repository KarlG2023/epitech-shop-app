import UIKit

protocol DetailPresenter {
    var view: DetailPresenterView? { get set }
    func viewDidLoad()

    func didTapAddButton()
    func didTapRemoveButton()
}

class DetailViewController: UIViewController {
    var presenter: DetailPresenter

    var mainView: View {
        view as! View
    }

    init(dependencies: Dependencies, product: Product) {
        self.presenter = DefaultDetailPresenter(
            cacheManager: dependencies.cacheManager,
            product: product
        )
        super.init(nibName: nil, bundle: nil)
        self.presenter.view = self
    }

    override func loadView() {
        view = View(addButtonAction: { [weak self] in
            self?.presenter.didTapAddButton()
        }, removeButtonAction: { [weak self] in
            self?.presenter.didTapRemoveButton()
        })
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        title = " "

        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension DetailViewController: DetailPresenterView {

    func apply(product: Product, quantity: Int) {
        mainView.apply(product: product, quantity: quantity)
    }
}

extension DetailViewController {

    class View: UIView {
        let addButtonAction: (() -> Void)?
        let removeButtonAction: (() -> Void)?

        let nameLabel = UILabel()
        let priceLabel = UILabel()
        let productImageView = UIImageView()
        let quantityLabel = UILabel()
        let addButton = UIButton()
        let removeButton = UIButton()
        let quantityValueLabel = UILabel()

        private enum Metrics {
            static let contentMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            static let titleToSubtitleMargin: CGFloat = 8
        }

        init(addButtonAction: (() -> Void)?, removeButtonAction: (() -> Void)?) {
            self.addButtonAction = addButtonAction
            self.removeButtonAction = removeButtonAction

            super.init(frame: .zero)
            backgroundColor = .systemBackground

            addSubview(nameLabel)
            addSubview(priceLabel)
            addSubview(productImageView)
            addSubview(quantityLabel)
            addSubview(addButton)
            addSubview(removeButton)
            addSubview(quantityValueLabel)

            setupLabels()
            setupImageView()
            setupButtons()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func setupLabels() {
            nameLabel.font = .boldSystemFont(ofSize: 20)
            priceLabel.font = .systemFont(ofSize: 16)
            quantityLabel.font = .systemFont(ofSize: 16)
            quantityValueLabel.font = .systemFont(ofSize: 16)

            quantityLabel.text = Constants.quantityLabel
        }

        func setupImageView() {
            productImageView.clipsToBounds = true
            productImageView.layer.cornerRadius = 8
        }

        func setupButtons() {
            addButton.backgroundColor = .label
            removeButton.backgroundColor = .label

            addButton.titleLabel?.textColor = .secondarySystemBackground
            removeButton.titleLabel?.textColor = .secondarySystemBackground

            removeButton.setTitle(" - ", for: .normal)
            addButton.setTitle(" + ", for: .normal)

            addButton.addAction(UIAction(handler: { [weak self] _ in
                self?.addButtonAction?()
            }), for: .touchUpInside)

            removeButton.addAction(UIAction(handler: { [weak self] _ in
                self?.removeButtonAction?()
            }), for: .touchUpInside)
        }

        override func layoutSubviews() {
            super.layoutSubviews()

            let imageViewWidth = bounds.width - Metrics.contentMargins.left - Metrics.contentMargins.right
            productImageView.frame = CGRect(
                x: Metrics.contentMargins.left,
                y: Metrics.contentMargins.top + safeAreaInsets.top,
                width: imageViewWidth,
                height: imageViewWidth / 1.5
            )
            productImageView.backgroundColor = .darkGray

            nameLabel.frame = CGRect(
                x: Metrics.contentMargins.left,
                y: Metrics.contentMargins.top + Metrics.titleToSubtitleMargin + productImageView.frame.height + productImageView.frame.origin.y,
                width: 0,
                height: 0
            )
            nameLabel.frame.size = nameLabel.sizeThatFits(
                CGSize(
                    width: bounds.width - Metrics.contentMargins.left - Metrics.contentMargins.right,
                    height: .greatestFiniteMagnitude
                )
            )

            priceLabel.frame = CGRect(
                x: Metrics.contentMargins.left,
                y: Metrics.titleToSubtitleMargin + nameLabel.frame.origin.y + nameLabel.frame.height,
                width: 0,
                height: 0
            )
            priceLabel.frame.size = priceLabel.sizeThatFits(
                CGSize(
                    width: bounds.width - Metrics.contentMargins.left - Metrics.contentMargins.right,
                    height: .greatestFiniteMagnitude
                )
            )

            quantityLabel.frame = CGRect(
                x: Metrics.contentMargins.left,
                y: Metrics.titleToSubtitleMargin + priceLabel.frame.origin.y + nameLabel.frame.height,
                width: 0,
                height: 0
            )
            quantityLabel.frame.size = quantityLabel.sizeThatFits(
                CGSize(
                    width: bounds.width - Metrics.contentMargins.left - Metrics.contentMargins.right,
                    height: .greatestFiniteMagnitude
                )
            )

            quantityValueLabel.frame = CGRect(
                x: quantityLabel.frame.origin.x + quantityLabel.frame.width,
                y: Metrics.titleToSubtitleMargin + priceLabel.frame.origin.y + nameLabel.frame.height,
                width: 0,
                height: 0
            )
            quantityValueLabel.frame.size = quantityValueLabel.sizeThatFits(
                CGSize(
                    width: bounds.width - Metrics.contentMargins.left - Metrics.contentMargins.right,
                    height: .greatestFiniteMagnitude
                )
            )

            removeButton.frame = CGRect(x: Metrics.contentMargins.left + quantityValueLabel.frame.width + quantityValueLabel.frame.origin.x, y: quantityValueLabel.frame.origin.y - 5, width: 30, height: 30)
            addButton.frame = CGRect(x: Metrics.contentMargins.left + removeButton.frame.width + removeButton.frame.origin.x, y: removeButton.frame.origin.y, width: 30, height: 30)
        }

        func apply(product: Product, quantity: Int) {
            nameLabel.text = "update this" // TODO: Set to the product name
            priceLabel.text = "update this" // TODO: use -> Int.currencyFormatted

            productImageView.image = .init() // UIImage.init(named: name)

            quantityValueLabel.text = String(quantity)

            setNeedsLayout()
        }

        enum Constants {
            static let quantityLabel = "Quantity: "
            static let defaultQuantity = 0
        }
    }
}
