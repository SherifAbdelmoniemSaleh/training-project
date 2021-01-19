//
//  BudgetTableViewCell.swift
//  BankingSystem
//
//  Created by Sherif Abd El-Moniem on 1/18/21.
//

import UIKit

class BudgetTableViewCell: UITableViewCell {
    @IBOutlet weak var budgetNameLabel: UILabel!
    @IBOutlet weak var lastLabel: UILabel!
    @IBOutlet weak var firstMonthLabel: UILabel!
    @IBOutlet weak var lastMonthLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
func setUpCell(budgetName : String , last : String  , firstMonth : String  ,lastMonth : String ){
        self.budgetNameLabel.text = budgetName
        self.lastLabel.text = last
        self.firstMonthLabel.text = firstMonth
        self.lastMonthLabel.text = lastMonth
    }
}
