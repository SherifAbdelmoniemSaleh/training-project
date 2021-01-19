//
//  BudgetviewModel.swift
//  BankingSystem
//
//  Created by Sherif Abd El-Moniem on 1/18/21.
//

import Foundation
class BudgetviewModel : AbstractViewModel{
    var budgetsList : [BudgetsModel] = []
    let manager = BudgetManager()
    func getAllBudgets ( onSuccess: @escaping () -> Void, onFail: @escaping (_ error: String) -> Void) {
       
        if Connectivity.isConnectedToInternet(){
            delegate?.viewStrartLoading()
        manager.getAllBudgets { (budgets) in
            self.budgetsList = budgets
            self.budgetsList.sort { $0.name < $1.name
            }
            onSuccess()
            self.delegate?.viewEndLoading()
        } onFail: { (error) in
            self.delegate?.showMessages(message: error)
            onFail(error)
        }
        }else{
            delegate?.showMessages(message: noInternetConnectionMessage)
        }
    }
}
