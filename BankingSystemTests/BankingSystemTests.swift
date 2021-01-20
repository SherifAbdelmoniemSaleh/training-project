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
    var viewController : AccountViewController!
    
    override func setUpWithError() throws {
        super.setUp()
        validation = AccountViewModel()
        manager = AccountManager()
        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AccountViewController") as! AccountViewController
        _ = viewController.view
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        super.tearDown()
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
                    ] ,
                    [
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
        
        manager.getAllAccounts(budgetId: "") { (accounts) in
            XCTAssertNotNil(accounts)
            XCTAssertTrue(accounts.count == 2)
            print(accounts.count)
        } onFail: { (error) in
            print(error)
        }
    }

    func testLibraryVC_TableViewShouldNotBeNil() {
        XCTAssertNotNil(viewController.accountsTableView)
    }
    
    func testDataSource_ViewDidLoad_SetsTableViewDataSource() {
        XCTAssertNotNil(viewController.accountsTableView.dataSource)
        XCTAssertTrue(viewController.accountsTableView.dataSource is AccountViewController)
    }
    
    // MARK: Delegate
    func testDelegate_ViewDidLoad_SetsTableViewDelegate() {
        XCTAssertNotNil(viewController.accountsTableView.delegate)
        XCTAssertTrue(viewController.accountsTableView.delegate is AccountViewController)
    }

}
