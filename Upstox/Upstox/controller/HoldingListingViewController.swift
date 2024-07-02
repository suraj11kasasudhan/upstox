
import UIKit

class HoldingListingViewController: UIViewController {
    private let toolBar  = UIView()
    private let toolBarHeight:CGFloat = 120
    private let tableView = UITableView()
    private let label = UILabel()
    private let getUserHoldingEndPoint = "https://35dee773a9ec441e9f38d5fc249406ce.api.mockbin.io/"
    private var userHoldings:[UserHolding]? = []
    private let profileIcon = UIImageView()
    private let titleLabel = UILabel()
    
    //Bottom sheet net P&L view
    private let netProfitAndLossView = UIView()
    private let expandedView = UIView()
    private var isExpanded:Bool = false
    private let separator = UIView()
    private let dropDownIcon = UIImageView()
    
    private let totalInvestmentLabel = UILabel()
    private let totalInvestmentValue = UILabel()
    
    private let currentInvestmentLabel = UILabel()
    private let currentInvestmentValue = UILabel()
    
    private let todayProfitAndLossLabel = UILabel()
    private let todayProfitAndLossValue = UILabel()
    
    private let netProfitAndLossLabel = UILabel()
    private let netProfitAndLossValue = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getHoldings()
        createViews()
        createNetProfitAndLossBottomView()
    }
    
    private func createViews(){
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(toolBar)
        toolBar.setTop(self.view)
        toolBar.setLeading(self.view)
        toolBar.setTrailing(self.view)
        toolBar.setViewHeight(toolBarHeight)
        toolBar.backgroundColor = themeColor
        
        toolBar.addSubview(profileIcon)
        profileIcon.setBottom(toolBar,constant: kSidePadding)
        profileIcon.setLeading(toolBar,constant: kSidePadding)
        profileIcon.image = UIImage(named: "profileIcon")
        
        
        toolBar.addSubview(titleLabel)
        titleLabel.setCenterY(profileIcon)
        titleLabel.setAfter(profileIcon,constant: kSidePadding)
        titleLabel.text = "Portfolio"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)

        self.view.addSubview(tableView)
        tableView.setBelow(toolBar)
        tableView.setLeading(self.view)
        tableView.setTrailing(self.view)
        tableView.setBottom(self.view)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HoldingListingTableViewCell.self, forCellReuseIdentifier: "holdingCell")
        
    }

    
    private func createNetProfitAndLossBottomView() {
        self.view.addSubview(netProfitAndLossView)
        netProfitAndLossView.setLeading(self.view)
        netProfitAndLossView.setTrailing(self.view)
        netProfitAndLossView.setBottom(self.view)
        netProfitAndLossView.setViewHeight(80)
        netProfitAndLossView.backgroundColor = themeGrayColor
        
        
        netProfitAndLossView.addSubview(netProfitAndLossLabel)
        netProfitAndLossLabel.setLeading(netProfitAndLossView, constant: kSidePadding)
        netProfitAndLossLabel.setBottom(netProfitAndLossView, constant: kSidePadding*2)
        netProfitAndLossLabel.text = "Profit & Loss*"
        netProfitAndLossLabel.textColor = UIColor.darkGray
        
        netProfitAndLossView.addSubview(netProfitAndLossValue)
        netProfitAndLossValue.setCenterY(netProfitAndLossLabel)
        netProfitAndLossValue.setTrailing(netProfitAndLossView, constant: kSidePadding)
        
        netProfitAndLossView.addSubview(dropDownIcon)
        dropDownIcon.setCenterY(netProfitAndLossLabel)
        dropDownIcon.setAfter(netProfitAndLossLabel, constant: kPadding10)
        dropDownIcon.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        dropDownIcon.image = UIImage(named: "upArrow")
        dropDownIcon.isUserInteractionEnabled = true
        dropDownIcon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideAndShowTotalProfitAndLossView)))
        netProfitAndLossView.backgroundColor = themeGrayColor
        
        netProfitAndLossView.addSubview(expandedView)
        expandedView.setBottom(netProfitAndLossLabel, constant: kSidePadding)
        expandedView.setTrailing(netProfitAndLossView)
        expandedView.setLeading(netProfitAndLossView)
        expandedView.backgroundColor = themeGrayColor
        expandedView.isHidden = true
        
        
        expandedView.addSubview(currentInvestmentLabel)
        currentInvestmentLabel.setTop(expandedView, constant: kPadding16)
        currentInvestmentLabel.setLeading(expandedView, constant: kSidePadding)
        currentInvestmentLabel.text = "Current value*"
        currentInvestmentLabel.textColor = UIColor.darkGray
        
        expandedView.addSubview(currentInvestmentValue)
        currentInvestmentValue.setCenterY(currentInvestmentLabel)
        currentInvestmentValue.setTrailing(expandedView, constant: kSidePadding)
        currentInvestmentValue.textColor = UIColor.darkGray
        
        expandedView.addSubview(totalInvestmentLabel)
        totalInvestmentLabel.setBelow(currentInvestmentLabel, constant: kPadding10)
        totalInvestmentLabel.setLeading(currentInvestmentLabel)
        totalInvestmentLabel.text = "Total investment*"
        totalInvestmentLabel.textColor = UIColor.darkGray
        
        expandedView.addSubview(totalInvestmentValue)
        totalInvestmentValue.setCenterY(totalInvestmentLabel)
        totalInvestmentValue.setTrailing(expandedView, constant: kSidePadding)
        totalInvestmentValue.textColor = UIColor.darkGray
        
        expandedView.addSubview(todayProfitAndLossLabel)
        todayProfitAndLossLabel.setBelow(totalInvestmentLabel, constant: kPadding10)
        todayProfitAndLossLabel.setLeading(totalInvestmentLabel)
        todayProfitAndLossLabel.text = "Today's Profit & Loss*"
        todayProfitAndLossLabel.textColor = UIColor.darkGray
        
        expandedView.addSubview(separator)
        separator.setBelow(todayProfitAndLossLabel, constant: kPadding10)
        separator.setLeading(expandedView)
        separator.setTrailing(expandedView)
        separator.setBottom(expandedView, constant: kPadding10)
        separator.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
        separator.setViewHeight(1.0)
        
        expandedView.addSubview(todayProfitAndLossValue)
        todayProfitAndLossValue.setCenterY(todayProfitAndLossLabel)
        todayProfitAndLossValue.setTrailing(expandedView, constant: kSidePadding)
        
    }
    
    private func setPortfolioSummaryData(){
        let portfolioSummary = calculatePortfolioSummary(holdings: self.userHoldings ?? [])
        currentInvestmentValue.text = "₹ \(portfolioSummary.currentValue )"
        totalInvestmentValue.text = "₹ \(portfolioSummary.totalInvestment)"
        todayProfitAndLossValue.text = portfolioSummary.todaysPNL < 0 ?  "- ₹ \(portfolioSummary.todaysPNL*(-1.0))" : "₹ \(portfolioSummary.todaysPNL)"
        netProfitAndLossValue.text = portfolioSummary.totalPNL < 0 ?  "- ₹ \(portfolioSummary.totalPNL*(0.1))" : "₹ \(portfolioSummary.totalPNL)"
        todayProfitAndLossValue.textColor = portfolioSummary.todaysPNL < 0 ? themeRedColor : themeGreebColor
        netProfitAndLossValue.textColor = portfolioSummary.totalPNL < 0 ? themeRedColor : themeGreebColor
        
    }
    

    @objc private func hideAndShowTotalProfitAndLossView() {
        if self.isExpanded {
            expandedView.isHidden = true
            self.expandedView.backgroundColor = UIColor.white
            self.isExpanded = false
            self.dropDownIcon.transform = CGAffineTransform(rotationAngle: 0)
            
        } else {
            expandedView.isHidden = false
            expandedView.backgroundColor = themeGrayColor
            self.isExpanded = true
            self.dropDownIcon.transform = CGAffineTransform(rotationAngle: .pi)
        }
    }
    
    func calculatePortfolioSummary(holdings: [UserHolding]) -> (currentValue: Double, totalInvestment: Double, totalPNL: Double, todaysPNL: Double) {
        var currentValue = 0.0
        var totalInvestment = 0.0
        var todaysPNL = 0.0
        
        for holding in holdings {
            let ltp = holding.ltp ?? 0.0
            let qty = holding.quantity ?? 0
            let avgPrice = holding.avgPrice ?? 0.0
            let closePrice = holding.close ?? 0.0
            
            currentValue =  currentValue + (ltp * Double(qty))
            totalInvestment = totalInvestment +  (avgPrice * Double(qty))
            todaysPNL =    todaysPNL +  ((closePrice - ltp) * Double(qty))
        }
        
        let totalPNL = currentValue - totalInvestment
        let roundedCurrentValue = round(currentValue * 100) / 100
        let roundedTotalInvestment = round(totalInvestment * 100) / 100
        let roundedTotalPNL = round(totalPNL * 100) / 100
        let roundedTodaysPNL = round(todaysPNL * 100) / 100
        
        return (roundedCurrentValue, roundedTotalInvestment, roundedTotalPNL, roundedTodaysPNL)
    }

    
    private func getHoldings(){
        APIHelperFunctions.shared().GET(urlString: getUserHoldingEndPoint,params: nil) { [weak self](status,data)  in
            guard let self = self else{return}
            if status == .success {
                if let model = try? JSONDecoder().decode(UserHoldingResponse.self, from: data!) {
                    if model.data?.userHolding?.count != 0 {
                        self.userHoldings = model.data?.userHolding ?? []
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            self.setPortfolioSummaryData()
                        }
                    }
                }
            }
        }
    }

}

extension HoldingListingViewController : UITableViewDataSource ,UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HoldingListingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "holdingCell") as! HoldingListingTableViewCell
        if let holding = self.userHoldings?[indexPath.row] {
            let returnsFromHolding = calculateProfitAndLoss(holding: holding)
            cell.set(name: holding.symbol ?? "", quantity: holding.quantity ?? 0, lastTradedPrice: holding.ltp ?? 0, profitAndLoss: returnsFromHolding)
        }
        return cell
    }
    
    func calculateProfitAndLoss(holding:UserHolding) -> Double{
        let currentValue = (holding.ltp ?? 0.0) * Double(holding.quantity ?? 0)
        let investedValue = (holding.avgPrice ?? 0.0) * Double(holding.quantity ?? 0)
        let profitAndLoss = currentValue - investedValue
        let formattedPNL = String(format: "%.2f", profitAndLoss)
        return Double(formattedPNL) ?? 0.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userHoldings?.count ?? 0
        
    }
}

