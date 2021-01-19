//
//  toryboardRouter.swift
//  BankingSystem
//
//  Created by Sherif Abd El-Moniem on 1/18/21.
//

import Foundation
import UIKit
class StoryboardRouter {
    private static func getStoryboard() -> UIStoryboard{
        return UIStoryboard(name: "Main", bundle: nil)
    }
    static func instantiateBudgetViewCOntroller() -> BudgetViewController {
        if let budgetVIewController  : BudgetViewController = getStoryboard().instantiateViewController(withIdentifier: "BudgetViewController") as? BudgetViewController {
            return budgetVIewController
        }
        
        return BudgetViewController()
    }
    static func instantiateAccountViewController() -> AccountViewController {
        if let accountViewController  : AccountViewController = getStoryboard().instantiateViewController(withIdentifier: "AccountViewController") as? AccountViewController {
            return accountViewController
        }
        return AccountViewController()
    }
    static func instantiateAddAccountViewController() -> AddAccountViewController {
        if let addAccountViewController  : AddAccountViewController = getStoryboard().instantiateViewController(withIdentifier: "AddAccountViewController") as? AddAccountViewController {
            return addAccountViewController
        }
        return AddAccountViewController()
    }
    
}
