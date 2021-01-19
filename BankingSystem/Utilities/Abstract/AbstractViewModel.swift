//
//  AbstractViewModel.swift
//  BankingSystem
//
//  Created by Sherif Abd El-Moniem on 19/01/2021.
//

import Foundation
protocol ViewModelDelegate {
    func viewStrartLoading()
    func viewEndLoading()
    func showMessages(message : String)
}
class AbstractViewModel {
 var delegate : ViewModelDelegate?
}
