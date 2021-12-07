import UIKit

class ProductTableViewCell: UITableViewCell {
    private enum Metrics {
        static let contentMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        static let imageSize = CGSize(width: 105, height: 70)
        static let titleToSubtitleMargin: CGFloat = 8
    }

    let nameLabel = UILabel()
    let priceLabel = UILabel()
    let productImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(nameLabel)
        addSubview(priceLabel)
        addSubview(productImageView)

        setupLabels()
        setupImageView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLabels() {
        nameLabel.font = .boldSystemFont(ofSize: 20)
        priceLabel.font = .systemFont(ofSize: 16)
    }

    func setupImageView() {
        productImageView.clipsToBounds = true
        productImageView.layer.cornerRadius = 8
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        productImageView.frame = CGRect(
            x: bounds.width - Metrics.contentMargins.right - Metrics.imageSize.width,
            y: Metrics.contentMargins.top,
            width: Metrics.imageSize.width,
            height: Metrics.imageSize.height
        )
        productImageView.backgroundColor = .darkGray

        nameLabel.frame = CGRect(
            x: Metrics.contentMargins.left,
            y: Metrics.contentMargins.top + Metrics.titleToSubtitleMargin,
            width: 0,
            height: 0
        )
        nameLabel.frame.size = nameLabel.sizeThatFits(
            CGSize(
                width: bounds.width - Metrics.contentMargins.left - Metrics.contentMargins.right - Metrics.imageSize.width,
                height: .greatestFiniteMagnitude
            )
        )

        priceLabel.frame = CGRect(
            x:  Metrics.contentMargins.left,
            y: Metrics.titleToSubtitleMargin + nameLabel.frame.origin.y + nameLabel.frame.height,
            width: 0,
            height: 0
        )
        priceLabel.frame.size = priceLabel.sizeThatFits(
            CGSize(
                width: bounds.width - Metrics.contentMargins.left - Metrics.contentMargins.right - Metrics.imageSize.width,
                height: .greatestFiniteMagnitude
            )
        )
    }

    func apply(product: Product) {
        nameLabel.text = "Update" // TODO: Update with product name
        priceLabel.text = "Update" // TODO: Update with product price.currencyFormatted

        productImageView.image = .init() // TODO: Update with product image name
        setNeedsLayout()
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let contentMargins = Metrics.contentMargins
        let contentRect = CGRect(
            origin: bounds.origin,
            size: CGSize(
                width: bounds.width - Metrics.contentMargins.right - Metrics.contentMargins.left - Metrics.imageSize.width,
                height: bounds.height
            )
        )
        let nameTextSize = nameLabel.sizeThatFits(contentRect.size)
        let priceTextSize = priceLabel.sizeThatFits(contentRect.size)

        let totalTextHeight = contentMargins.top + nameTextSize.height + priceTextSize.height + contentMargins.bottom + Metrics.titleToSubtitleMargin
        let imageHeight = Metrics.imageSize.height + Metrics.contentMargins.top + Metrics.contentMargins.bottom
        let totalHeight = totalTextHeight > imageHeight ? totalTextHeight : imageHeight

        return CGSize(width: bounds.width, height: totalHeight)
    }
}
