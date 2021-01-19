//
//  BudgetViewController.swift
//  BankingSystem
//
//  Created by Sherif Abd El-Moniem on 1/18/21.
//

import UIKit

class BudgetViewController : AbstractViewController {
    
    @IBOutlet weak var budgetTableView: UITableView!
    let budgetTableViewCellIdentifire = "BudgetTableViewCell"
    let viewModel = BudgetviewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1478265226, green: 0.5686329007, blue: 0.7501782775, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    func setUp(){
        // view model
        viewModel.delegate = self
        // navigation bar
        navigationBarSetup()
        // table view
        budgetTableView.delegate = self
        budgetTableView.dataSource = self
        registerTableViewCell()
        // call API
        viewModel.getAllBudgets {
            self.budgetTableView.reloadData()
            
            
        } onFail: { (error) in
            print("error \(error)")
        }
    }
    func navigationBarSetup(){
        let logo = UILabel()
        logo.text = myBudgetString
        logo.textColor =  .white
        self.navigationItem.titleView = logo
    }
    func registerTableViewCell(){
        budgetTableView.register(UINib(nibName: budgetTableViewCellIdentifire, bundle: nil), forCellReuseIdentifier: budgetTableViewCellIdentifire)
    }
}
extension BudgetViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.budgetsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: budgetTableViewCellIdentifire ,for:  indexPath) as? BudgetTableViewCell {
            cell.setUpCell(budgetName: viewModel.budgetsList[indexPath.row].name , last: viewModel.budgetsList[indexPath.row].last_modified_on , firstMonth: viewModel.budgetsList[indexPath.row].first_month, lastMonth: viewModel.budgetsList[indexPath.row].last_month)
            return cell
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let accountsViewController = StoryboardRouter.instantiateAccountViewController()
        accountsViewController.budgetId = viewModel.budgetsList[indexPath.row].id
        navigationController?.pushViewController(accountsViewController, animated: true)
    }
}
extension  BudgetViewController : ViewModelDelegate {
    
    func showMessages(message: String) {
        endLoading()
        showMsg(msg: message)
    }
    func viewStrartLoading() {
        startLoading()
    }
    
    func viewEndLoading() {
        endLoading()
    }
}
