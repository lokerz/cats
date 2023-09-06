//
//  TabC.swift
//  Cats
//
//  Created by Ridwan Abdurrasyid on 06/09/23.
//

import UIKit

class TabC: UITabBarController, UITabBarControllerDelegate {
    
    var onViewDidLoad: ((UINavigationController) -> Void)?
    var onTheFirstSelected: ((UINavigationController) -> Void)?
    var onTheSecondSelected: ((UINavigationController) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.tabBar.unselectedItemTintColor = .lightGray
        self.tabBar.tintColor = .systemCyan
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let controller = customizableViewControllers?.first as? UINavigationController {
            self.onViewDidLoad?(controller)
        }
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let controller = viewControllers?[selectedIndex] as? UINavigationController else { return }
        
        if selectedIndex == 0 {
            self.onTheFirstSelected?(controller)
        } else if selectedIndex == 1 {
            self.onTheSecondSelected?(controller)
        }
    }
    
    func setupUI() {
        // Create Tab one
        let tabOne = UINavigationController()
        let imageOne = UIImage(named: "cat.fill")
        let tabOneBarItem = UITabBarItem(title: "Cats", image: imageOne, selectedImage: imageOne)
        
        tabOne.tabBarItem = tabOneBarItem
        
        
        // Create Tab two
        let tabTwo = UINavigationController()
        let imageTwo = UIImage(named: "dog.fill")
        let tabTwoBarItem = UITabBarItem(title: "Dogs", image: imageTwo, selectedImage: imageTwo)

        tabTwo.tabBarItem = tabTwoBarItem
        
        self.viewControllers = [tabOne, tabTwo]
    }
}
