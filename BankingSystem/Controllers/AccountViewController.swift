//
//  AccountViewController.swift
//  BankingSystem
//
//  Created by Sherif Abd El-Moniem on 1/18/21.
//

import UIKit

class AccountViewController : AbstractViewController {
    
    @IBOutlet weak var accountsTableView: UITableView!
    let accountTableViewCellIdentifire = "AccountTableViewCell"
    let viewModel = AccountViewModel()
    var budgetId : String = ""
    
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
    @IBAction func addAccountButtonAction(_ sender: Any) {
        let addAccountViewController = StoryboardRouter.instantiateAddAccountViewController()
        addAccountViewController.budgetId = self.budgetId
        addAccountViewController.callBack = {(isRefresh : Bool) in
            if isRefresh{
                self.callAPI()
            }
        }
        navigationController?.pushViewController(addAccountViewController, animated: true)
    }
    
    func setUp(){
        // view Model
        viewModel.delegate = self
        // navigatrion Bar
        navigationBarSetup()
        // table view
        accountsTableView.delegate = self
        accountsTableView.dataSource = self
        registerTableViewCell()
        // call API
        callAPI()
        
    }
    func callAPI(){
        viewModel.getAllAccounts (budgetId: budgetId){
            self.accountsTableView.reloadData()
        } onFail: { (error) in
            print("error \(error)")
        }
    }
    func navigationBarSetup(){
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.backgroundColor = .clear
        button.setTitleColor(.white, for: .normal)
        button.setTitle(backString, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.addTarget(self, action:#selector(backBtn), for: .touchUpInside)
        NSLayoutConstraint.activate([
                                        button.widthAnchor.constraint(equalToConstant: 40) ,
                                        button.heightAnchor.constraint(equalToConstant: 40)])
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItems = [barButton]
        let titleLabel = UILabel()
        titleLabel.textColor =  .white
        titleLabel.text = accountString
        self.navigationItem.titleView = titleLabel
    }
    @objc func backBtn (){
        self.navigationController?.popViewController(animated: true)
    }
    func registerTableViewCell(){
        accountsTableView.register(UINib(nibName: accountTableViewCellIdentifire, bundle: nil), forCellReuseIdentifier: accountTableViewCellIdentifire)
    }
}
extension AccountViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.accountsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: accountTableViewCellIdentifire ,for:  indexPath) as? AccountTableViewCell {
            cell.setUp(accountName: viewModel.accountsList[indexPath.row].name , accountBalance: viewModel.accountsList[indexPath.row].balance)
            return cell
        }
        return UITableViewCell()
    }
}
extension  AccountViewController : ViewModelDelegate {
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
