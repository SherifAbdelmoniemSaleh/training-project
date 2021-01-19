//
//  AccountModel.swift
//  BankingSystem
//
//  Created by Sherif Abd El-Moniem on 1/18/21.
//

import Foundation
import SwiftyJSON
class AccountModel : BaseModel {
    var name : String = ""
    var type  : String = ""
    var on_budget  : Bool = false
    var closed : Bool = false
    var note : String = ""
    var balance : Int = 0
    var cleared_balance  : Int = 0
    var uncleared_balance : Int = 0
    var transfer_payee_id : String = ""
    var deleted : Bool = false
    
    override init() {
        super.init()
    }
    
    required init(data: JSON) {
        super.init(data: data)
        name = data.getStringValue(forKey: "name")
        type = data.getStringValue(forKey: "type")
        on_budget = data.getBoolValue(forKey: "on_budget")
        closed = data.getBoolValue(forKey: "closed")
        note = data.getStringValue(forKey: "note")
        balance = data.getIntValue(forKey: "balance")
        cleared_balance = data.getIntValue(forKey: "body")
        uncleared_balance = data.getIntValue(forKey: "uncleared_balance")
        transfer_payee_id = data.getStringValue(forKey: "transfer_payee_id")
        deleted = data.getBoolValue(forKey: "deleted")
    }
    
    class func arrayFromInstance (array : [JSON]?) -> [AccountModel]?{
        if let count = array?.count, count > 0 {
            return array?.map{
                json -> AccountModel in
                return self.init(data: json)
            }
        }
        return nil
    }
}

