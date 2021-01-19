//
//  BaseManager.swift
//  BankingSystem
//
//  Created by Sherif Abd El-Moniem on 1/18/21.
//

import Foundation
import Alamofire
import SwiftyJSON
class BaseManager {    
    func request (url: String, params: Parameters?, method: HTTPMethod, addationalHeader: HTTPHeaders? = nil,  encoding: ParameterEncoding, onSuccess: @escaping(_ response: JSON) -> Void, onFail: @escaping(_ error: String) -> Void) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer 368e0734f1b97d289c41dab0fc9067c7c7fb42ff4a9a33b97221177d6df87953",
            "Accept": "application/json"
        ]
//        let headers = ["Authorization": "Bearer 368e0734f1b97d289c41dab0fc9067c7c7fb42ff4a9a33b97221177d6df87953"]
        if let _ = NetworkReachabilityManager()?.isReachable {
            
            AF.request(url, method: method, parameters: params,encoding: encoding, headers : headers).responseData { (response) in
                
                switch response.result {
                case .success(let result):
                    //check metas first and then send the success response
                    let jsonResponse = JSON(result)
                            onSuccess(JSON(jsonResponse))
                            return
                case .failure(let error) :
                    onFail(error.localizedDescription)
                    return
                }
            }
        } else {
            onFail("no Connection Error")
            return
        }
    }
}



