//
//  BaseVC.swift
//  Cats
//
//  Created by Ridwan Abdurrasyid on 31/08/23.
//

import UIKit

protocol Bindable {
    func setupVM()
}

class BaseVC: UIViewController, Bindable {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupVM()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupVM() {
        
    }
}

extension UIViewController {
    func wrapInNavigationController() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
}

