//
//  AbstractViewController.swift
//  BankingSystem
//
//  Created by Sherif Abd El-Moniem on 19/01/2021.
//

import Foundation
import MBProgressHUD
class AbstractViewController : UIViewController {
    var hud : MBProgressHUD?
    func showMsg(msg :String){
        DispatchQueue.main.async {
            guard let view = self.navigationController?.view ?? self.view else { return }
            let hud = MBProgressHUD.showAdded(to: view, animated: true)
            hud.isUserInteractionEnabled = false
            hud.mode = .text
            hud.label.text = msg
            hud.label.numberOfLines = 0
            hud.margin = 10
            hud.offset.y = 150
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 3)
        }
    }
    func startLoading(){
        //TODO : Add progress HUD
        DispatchQueue.main.async {
            // Start HUD
            self.hud?.hide(animated: true)
            self.hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            self.hud?.label.text = "loading..."
            self.hud?.show(animated: true)
        }
    }
    // hides the appered Loader view
    func endLoading(){
        //TODO: Stop progress HUD
        DispatchQueue.main.async {
            // Stop HUD
            self.hud?.hide(animated: true)
        }
    }
}
