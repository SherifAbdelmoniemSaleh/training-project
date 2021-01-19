//
//  AccountViewModel.swift
//  BankingSystem
//
//  Created by Sherif Abd El-Moniem on 1/18/21.
//

import Foundation
class AccountViewModel : AbstractViewModel {
    let manager = AccountManager()
    var accountsList : [AccountModel] = []
    
    func validateBalance(balance : String) -> Bool{
        if balance.isEmpty || Int(balance)! < 0 {
            return false
        }else{
            return true
        }
    }
    
    func validateName(name : String) -> Bool{
        if name.isEmpty {
            return false
        }else{
            return true
        }
    }
    
    func addAccount(budgetId: String ,name : String , type : String , balance : Int , onSuccess: @escaping () -> Void, onFail: @escaping (_ error: String) -> Void) {
        if Connectivity.isConnectedToInternet(){
            delegate?.viewStrartLoading()
            manager.addAccount(budgetId: budgetId, name: name, type: type, balance: balance) {
                self.delegate?.viewEndLoading()
            onSuccess()
        } onFail: { (error) in
            self.delegate?.showMessages(message: error)
            onFail(error)
            
        }
        }else{
            delegate?.showMessages(message: noInternetConnectionMessage)
        }
    }
    func getAllAccounts( budgetId : String ,onSuccess: @escaping () -> Void, onFail: @escaping (_ error: String) -> Void) {
        if Connectivity.isConnectedToInternet(){
            delegate?.viewStrartLoading()
        manager.getAllAccounts(budgetId: budgetId) { (accounts) in
            self.accountsList = accounts
            self.accountsList.sort {
                $0.balance > $1.balance
            }
            self.delegate?.viewEndLoading()
            onSuccess()
        } onFail: { (error) in
            self.delegate?.showMessages(message: error)
            onFail(error)
        }
        
    }else{
        delegate?.showMessages(message: noInternetConnectionMessage)
    }
}
    
}

  
