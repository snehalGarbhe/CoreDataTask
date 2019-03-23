//
//  BaseVC.swift
//  CoreDataTask
//
//  Created by Snehal Garbhe on 3/21/19.
//  Copyright © 2019 Snehal Garbhe. All rights reserved.
//

import Foundation
import UIKit
import JGProgressHUD


class BaseVC: UIViewController {
    var alertVC: UIAlertController?
    var progressHud: JGProgressHUD?
    
    func showAlert(_ title: String?,
                   message: String?,
                   defaultBtnTitle: String? = nil,
                   defaultAction: ((UIAlertAction) -> Void)? = nil,
                   destructiveBtnTitle: String? = nil,
                   destructiveAction: ((UIAlertAction) -> Void)? = nil) {
        
        let alertVC = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let defaultTitle = defaultBtnTitle ?? "Ok"
        alertVC.addAction(UIAlertAction.init(title: defaultTitle, style: .cancel, handler: defaultAction))
        
        if let _ = destructiveAction {
            let destructiveTitle = destructiveBtnTitle ?? "Cancel"
            alertVC.addAction(UIAlertAction.init(title: destructiveTitle, style: .destructive, handler: destructiveAction))
        }
        
        self.present(alertVC, animated: true, completion: nil)
    }
    func showHud() {
        self.progressHud = JGProgressHUD(style: .dark)
        self.progressHud! .textLabel.text = "Loading"
        self.progressHud? .show(in: self.view) 
    }
    func hideHud() {
        DispatchQueue.main.async {
            self.progressHud!.dismiss(animated: true)
        }
    }
}
