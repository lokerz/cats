//
//  AlertManager.swift
//  Cats
//
//  Created by Ridwan Abdurrasyid on 06/09/23.
//

import UIKit

class AlertManager {
    static let shared = AlertManager()
    
    func showAlert(status: Int, message: String){
        let alert = UIAlertController(title: "Error \(status)", message: message, preferredStyle: .alert)
        let open = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(open)
        
        var root = UIApplication.shared.keyWindow?.rootViewController
        if let nav = root as? UINavigationController {
            root = nav.viewControllers.first
        }
        if let tab = root as? UITabBarController {
            root = tab.selectedViewController
        }
        
        DispatchQueue.main.async {
            root?.present(alert, animated: true, completion: nil)
        }
    }
}
