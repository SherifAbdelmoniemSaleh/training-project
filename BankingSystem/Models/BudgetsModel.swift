//
//  BudgetsModel.swift
//  BankingSystem
//
//  Created by Sherif Abd El-Moniem on 1/18/21.
//


import Foundation
import SwiftyJSON
class BudgetsModel : BaseModel {
    var name : String = ""
    var last_modified_on  : String = ""
    var first_month : String = ""
    var last_month : String = ""
    var accounts : [AccountModel] = []
    override init() {
        super.init()
    }
    
    required init(data: JSON) {
        super.init(data: data)
        name = data.getStringValue(forKey: "name")
        last_modified_on = data.getStringValue(forKey: "last_modified_on")
        first_month = data.getStringValue(forKey: "first_month")
        last_month = data.getStringValue(forKey: "last_month")
        accounts = AccountModel.arrayFromInstance(array: data["accounts"].array) ?? []
    }
    
    class func arrayFromInstance (array : [JSON]?) -> [BudgetsModel]?{
        if let count = array?.count, count > 0 {
            return array?.map{
                json -> BudgetsModel in
                return self.init(data: json)
            }
        }
        return nil
    }
}

