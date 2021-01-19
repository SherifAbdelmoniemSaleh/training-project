//
//  AccountManager.swift
//  BankingSystem
//
//  Created by Sherif Abd El-Moniem on 1/18/21.
//

import Foundation
import Alamofire
class AccountManager :BaseManager {
    
    /*
     “account”: {
             “name”: “My Test Account”,
             “type”: “savings”,
             “balance”: 10000
         }

     */
    
    func addAccount(budgetId: String ,name : String , type : String , balance : Int ,  onSuccess: @escaping () -> Void, onFail: @escaping (_ error: String) -> Void){
        let url = baseUrl + "/\(budgetId)" + accountUrl
        var param  : [String : Any] = [:]
        let accountDetails : [String : Any] = [ "name" : name , "type" : type , "balance" : balance
        ]
        param["account"] = accountDetails
        request(url: url, params: param, method: .post, encoding:JSONEncoding.default ) { (responce) in
            onSuccess()
        } onFail: { (error) in
            onFail(error)
        }
    }
    func getAllAccounts(budgetId: String , onSuccess: @escaping ([AccountModel]) -> Void, onFail: @escaping (_ error: String) -> Void) {
        let url = baseUrl + "/\(budgetId)" + accountUrl
        request(url: url, params: nil, method: .get, encoding: URLEncoding.default) { (responce) in
            if let list = responce["data"]["accounts"].array{
                if let accounts  = AccountModel.arrayFromInstance(array: list) {
                    onSuccess(accounts)
                }else {
                    onSuccess([])
                }
            }else{
                onSuccess([])
            }
        } onFail: { (error) in
            onFail(error)
        }
    }
}
