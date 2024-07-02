import Foundation
import UIKit

class HoldingListingTableViewCell: UITableViewCell {
    
    private let holdingName = UILabel()
    private let quantityLabel = UILabel()
    private let quantityValue = UILabel()
    private let profitAndLossLabel = UILabel()
    private let profitAndLossValue = UILabel()
    private let lastTradedPriceLabel = UILabel()
    private let lastTradedPriceValue =  UILabel()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        holdingName.text = ""
        quantityValue.text = ""
        profitAndLossValue.text = ""
        lastTradedPriceValue.text = ""
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createViews() {
        self.contentView.addSubview(holdingName)
        holdingName.setTop(self.contentView,constant: kSidePadding)
        holdingName.setLeading(self.contentView,constant: kSidePadding)
        holdingName.font = UIFont.boldSystemFont(ofSize: 14)
        
        self.contentView.addSubview(quantityLabel)
        quantityLabel.setLeading(holdingName)
        quantityLabel.setBelow(holdingName,constant: kPadding12)
        quantityLabel.text = "NET QTY: "
        quantityLabel.setBottom(self.contentView,constant: kSidePadding)
        quantityLabel.textColor = UIColor.gray
        quantityLabel.font = UIFont.systemFont(ofSize: 12)
        
        self.contentView.addSubview(quantityValue)
        quantityValue.setCenterY(quantityLabel)
        quantityValue.setAfter(quantityLabel,constant: kPadding6)
        quantityValue.font = UIFont.systemFont(ofSize: 14)
    
        
        self.contentView.addSubview(lastTradedPriceValue)
        lastTradedPriceValue.setCenterY(holdingName)
        lastTradedPriceValue.setTrailing(self.contentView,constant: kSidePadding)
        lastTradedPriceValue.textColor = UIColor.darkGray
        
        self.contentView.addSubview(lastTradedPriceLabel)
        lastTradedPriceLabel.setBefore(lastTradedPriceValue,constant: kPadding6)
        lastTradedPriceLabel.setCenterY(lastTradedPriceValue)
        lastTradedPriceLabel.text = "LTP: "
        lastTradedPriceLabel.textColor = UIColor.gray
        lastTradedPriceLabel.font = UIFont.systemFont(ofSize: 12)
        
        self.contentView.addSubview(profitAndLossValue)
        profitAndLossValue.setCenterY(quantityLabel)
        profitAndLossValue.setTrailing(self.contentView,constant: kSidePadding)
        
        self.contentView.addSubview(profitAndLossLabel)
        profitAndLossLabel.setBefore(profitAndLossValue,constant: kPadding6)
        profitAndLossLabel.setCenterY(quantityLabel)
        profitAndLossLabel.text = "P&L: "
        profitAndLossLabel.textColor = UIColor.gray
        profitAndLossLabel.font = UIFont.systemFont(ofSize: 12)
        
    }
    
    func set(name:String,quantity:Int,lastTradedPrice:Double,profitAndLoss:Double) {
        holdingName.text = name
        quantityValue.text = "\(quantity)"
        lastTradedPriceValue.text = " ₹ \(lastTradedPrice)"
        profitAndLossValue.text =   profitAndLoss < 0 ? " - ₹ \(profitAndLoss*(-1.0))" : " ₹ \(profitAndLoss)"
        profitAndLossValue.textColor = profitAndLoss < 0 ? themeRedColor : themeGreebColor
    }
}
