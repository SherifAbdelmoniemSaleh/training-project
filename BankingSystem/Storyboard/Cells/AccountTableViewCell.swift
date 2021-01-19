//
//  AccountTableViewCell.swift
//  BankingSystem
//
//  Created by Sherif Abd El-Moniem on 1/18/21.
//

import UIKit

class AccountTableViewCell: UITableViewCell {
    @IBOutlet weak var accountNameLabel: UILabel!
    
    @IBOutlet weak var accountBalanceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUp(accountName : String , accountBalance : Int){
        self.accountNameLabel.text = accountName
        self.accountBalanceLabel.text = "\(accountBalance)"
    }
    
}
