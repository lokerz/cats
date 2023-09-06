//
//  AppCoordinator.swift
//  Cats
//
//  Created by Ridwan Abdurrasyid on 31/08/23.
//

import Foundation

class AppCoordinator: BaseCoordinator {
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    override func start() {
        self.runMenubarFlow()
    }
    
    private func runMenubarFlow() {
        let module = TabC()
        let coordinator = MenubarCoordinator(tab: module)
        
        self.addDependency(coordinator)
        self.router.setRootModule(module, hideBar: true, animation: .bottomUp)
        
        coordinator.start()
    }
}
