//
//  Connectivity.swift
//  BankingSystem
//
//  Created by Sherif Abd El-Moniem on 1/18/21.
//

import Foundation
import Alamofire


class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
