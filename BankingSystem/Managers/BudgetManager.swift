//
//  BudgetManager.swift
//  BankingSystem
//
//  Created by Sherif Abd El-Moniem on 1/18/21.
//

import Foundation
import  Alamofire
class BudgetManager : BaseManager {
    func getAllBudgets ( onSuccess: @escaping ([BudgetsModel]) -> Void, onFail: @escaping (_ error: String) -> Void) {
        let url = baseUrl + budgetUrl
        request(url: url, params: nil, method: .get, encoding: URLEncoding.default) { (responce) in
            if let list = responce["data"]["budgets"].array{
                if let budgets  = BudgetsModel.arrayFromInstance(array: list) {
                    onSuccess(budgets)
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
