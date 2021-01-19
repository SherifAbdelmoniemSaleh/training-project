//
//  BankingSystemTests.swift
//  BankingSystemTests
//
//  Created by Sherif Abd El-Moniem on 1/18/21.
//

import XCTest
@testable import BankingSystem
@testable import OHHTTPStubs

class BankingSystemTests: XCTestCase {
    
    
    var validation : AccountViewModel!
    var manager : AccountManager!
    
    override func setUpWithError() throws {
        validation = AccountViewModel()
        manager = AccountManager()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        validation = nil
        manager = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_is_valid_name() throws {
        let isValid = validation.validateName(name: "ee")
        XCTAssertTrue(isValid)
    }
    func test_is_valid_balance() throws {
        let isValid = validation.validateBalance(balance: "1")
        XCTAssertTrue(isValid)
    }
    
    func testExample() throws {
        stub { (URLRequest) -> Bool in
            return URLRequest.url?.absoluteString.contains("/accounts") ?? false
        } response: { (URLRequest) -> HTTPStubsResponse in
            let jsonObject = [ "data" : [
                "accounts" : [
                    [
                        "id" : "f408ddbb-8b43-4fcb-ab40-e1d28a1d9e34",
                        "name" : "said",
                        "type" : "creditCard",
                        "on_budget" : true,
                        "closed" : false,
                        "note" : nil,
                        "balance" : 56000,
                        "cleared_balance" : 56000,
                        "uncleared_balance" : 0,
                        "transfer_payee_id" : "e9d84cc6-d17f-40ab-b874-8ce7fd52b0b7",
                        "deleted" : false
                    ] ,[
                        "id" : "f4d08ddbb-8b43-4fcb-ab40-e1d28a1d9e34",
                        "name" : "said",
                        "type" : "creditCard",
                        "on_budget" : true,
                        "closed" : false,
                        "note" : nil,
                        "balance" : 56000,
                        "cleared_balance" : 56000,
                        "uncleared_balance" : 0,
                        "transfer_payee_id" : "e9d84cc6-d17f-40ab-b874-8ce7fd52b0b7",
                        "deleted" : false
                    ]
                ]
                
            ]
            ]
            return HTTPStubsResponse(jsonObject : jsonObject , statusCode: 200 , headers:  nil)
        }
        var expectResponce : [AccountModel]? = nil
        let exception = self.expectation(description: "Network Failed")
        
        manager.getAllAccounts(budgetId: "") { (accounts) in
            expectResponce = accounts
            print(accounts.count)
            exception.fulfill()
        } onFail: { (error) in
            print(error)
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNotNil(expectResponce)
        XCTAssertTrue(expectResponce?.count == 2)
        
    }
}
