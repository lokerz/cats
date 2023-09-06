//
//  MenubarCoordinator.swift
//  Cats
//
//  Created by Ridwan Abdurrasyid on 06/09/23.
//

import Foundation
import UIKit

class MenubarCoordinator: BaseCoordinator {
    private let tab: TabC
    
    init(tab: TabC) {
        self.tab = tab
    }
    
    override func start() {
        self.showMenubar()
    }
    
    private func showMenubar(){
        self.tab.onViewDidLoad = self.runTheFirstFlow()
        self.tab.onTheFirstSelected = self.runTheFirstFlow()
        self.tab.onTheSecondSelected = self.runTheSecondFlow()
    }
    
    private func runTheFirstFlow() -> ((UINavigationController) -> Void) {
        return { [unowned self] navController in
            if navController.viewControllers.isEmpty {
                self.showCatsView(nav: navController)
            }
        }
    }
    
    private func runTheSecondFlow() -> ((UINavigationController) -> Void) {
        return { [unowned self] navController in
            if navController.viewControllers.isEmpty {
                self.showDogsView(nav: navController)
            }
        }
    }
    
    func showCatsView(nav: UINavigationController) {
        let module = CatsVC()
        
        let vm = CatsVM()
        vm.imageAPI = CatsImageAPI()
        vm.textAPI = CatsAPI()
        
        module.viewModel = vm
        
        let router = Router(rootController: nav)
        router.setRootModule(module)
    }
    
    func showDogsView(nav: UINavigationController) {
        let module = DogsVC()
        
        let vm = DogsVM()
        vm.imageAPI = DogsImageAPI()
        vm.textAPI = DogsAPI()
        
        module.dogsViewModel = vm
        
        let router = Router(rootController: nav)
        router.setRootModule(module)
    }
}
