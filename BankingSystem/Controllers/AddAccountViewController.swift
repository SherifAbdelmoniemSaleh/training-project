//
//  AddAccountViewController.swift
//  BankingSystem
//
//  Created by Sherif Abd El-Moniem on 1/18/21.
//

import UIKit

enum AccountType : CaseIterable {
    case checking
    case savings
    case creditCard
    func getText() -> String{
        switch self {
        case .checking :
            return "Checking"
        case .creditCard :
            return "Credit Card"
        case .savings :
            return "Saving"
        }
    }
    
    func getValue() -> String{
        switch self {
        case .checking :
            return "checking"
        case .creditCard :
            return "creditCard"
        case .savings :
            return "savings"
        }
    }
}

class AddAccountViewController: AbstractViewController {
    let viewModel = AccountViewModel()
    var accountType  : AccountType = .checking
    var budgetId : String = ""
    var callBack: ((_ isRefresh : Bool)-> Void)?
    @IBOutlet weak var accountBalanceTextField: UITextField!
    @IBOutlet weak var accountNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // view model
        viewModel.delegate = self
        // navigation bar
        navigationBarSetup()
    }
    func navigationBarSetup(){
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.backgroundColor = .clear
        button.setTitleColor(.white, for: .normal)
        button.setTitle( backString, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.addTarget(self, action:#selector(backBtn), for: .touchUpInside)
        NSLayoutConstraint.activate([
                                        button.widthAnchor.constraint(equalToConstant: 40) ,
                                        button.heightAnchor.constraint(equalToConstant: 40)])
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItems = [barButton]
        let titleLabel = UILabel()
        titleLabel.textColor =  .white
        titleLabel.text = newAccountString
        self.navigationItem.titleView = titleLabel
    }
    @objc func backBtn (){
        self.navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1478265226, green: 0.5686329007, blue: 0.7501782775, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    @IBAction func accountTypeButtonAction(_ sender: Any) {
        let alertType = UIAlertController(title: accountTypeString, message: accountTypeMessage, preferredStyle: .actionSheet)
        AccountType.allCases.forEach {type in
            alertType.addAction( UIAlertAction(title: type.getText(), style: .default , handler: { (UIAlertAction) in
                self.accountType = type
            }))
        }
        alertType.addAction(UIAlertAction(title: cancelString, style: .cancel))
        self.present(alertType, animated: true)
        
    }
    
    @IBAction func addAccountButtonAction(_ sender: Any) {
        if let balance = accountBalanceTextField.text , let name = accountNameTextField.text {
            // show toast
            if !viewModel.validateName(name: name){
                self.showMsg(msg: invalidNameMessage)
                return
            }
            if !viewModel.validateBalance(balance: balance){
                self.showMsg(msg:invalidBalanceMessage)
                return
            }

            let alertAdd = UIAlertController(title: addAccountString, message: addAccountMessage, preferredStyle: .alert)
            alertAdd.addAction(UIAlertAction(title: okString , style: .destructive, handler: { (UIAlertAction) in
                // call API
                self.viewModel.addAccount(budgetId: self.budgetId , name: name, type: self.accountType.getValue(), balance: Int(balance) ?? 0) {
                    self.callBack?(true)
                    self.navigationController?.popViewController(animated: true)
                } onFail: { (error) in
                    print("error \(error)")
                }
                
                
            }))
            alertAdd.addAction(UIAlertAction(title: cancelString, style: .cancel))
            self.present(alertAdd, animated: true)
        }
    }
}
extension  AddAccountViewController : ViewModelDelegate {
    
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
