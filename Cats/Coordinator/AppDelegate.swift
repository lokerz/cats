//
//  AppDelegate.swift
//  Cats
//
//  Created by Ridwan Abdurrasyid on 31/08/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private lazy var appCoordinator: Coordinator = self.makeCoordinator()
    var rootController: UINavigationController {
        return self.window!.rootViewController as! UINavigationController
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = UINavigationController()
        self.window?.backgroundColor = .white
        self.window?.makeKeyAndVisible()
        
        self.appCoordinator.start()
        
        return true
    }

    private func makeCoordinator() -> Coordinator {
        return AppCoordinator(router: Router(rootController: self.rootController))
    }
}

