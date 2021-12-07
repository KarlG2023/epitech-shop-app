import Foundation

extension Int {

    static var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter
    }()

    var currencyFormatted: String {
        Self.currencyFormatter.string(from: NSNumber(value: Float(self)/100))!
    }
}
