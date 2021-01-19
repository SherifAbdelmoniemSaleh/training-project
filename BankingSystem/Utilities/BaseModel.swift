//
//  BaseModel.swift
//  BankingSystem
//
//  Created by Sherif Abd El-Moniem on 1/18/21.
//


import Foundation
import UIKit
import SwiftyJSON

class BaseModel {
    
    
    var id : String = ""
    var data = JSON()
    
    init() {}
    
    required init(data : JSON){
        self.data = data
        id = data.getStringValue(forKey: "id")
    }
    
}

extension BaseModel: Hashable {
    static func == (lhs: BaseModel, rhs: BaseModel) -> Bool {
        return lhs === rhs
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self).hashValue)
    }
}
