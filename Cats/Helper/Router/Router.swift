//
//  Router.swift
//  Cats
//
//  Created by Ridwan Abdurrasyid on 06/09/23.
//

import UIKit

class Router {
    private weak var rootController: UINavigationController?
    private var completions: [UIViewController : () -> Void]

    init(rootController: UINavigationController) {
        self.rootController = rootController
        self.completions = [:]
    }
    
    func toPresent() -> UIViewController? {
        return self.rootController
    }
    
    func availableViewController() -> UIViewController? {
        return self.rootController?.viewControllers.last
    }
    
    func present(_ module: Presentable?, animated: Bool = true, mode: PresentMode = .fullScreen, isWrapNavigation: Bool = false) {
        guard var controller = module?.toPresent() else { return }
        if isWrapNavigation {
            controller = controller.wrapInNavigationController()
        }
        
        switch mode {
        case .fullScreen:
            controller.modalPresentationStyle = .fullScreen
        case .overContext:
            controller.modalPresentationStyle = .overCurrentContext
        default:
            break
        }
        self.rootController?.present(controller, animated: animated, completion: nil)
    }
        
    func dismissModule(animated: Bool = true, completion: (() -> Void)?) {
        self.rootController?.dismiss(animated: animated, completion: completion)
    }
    
    func push(_ module: Presentable?, animated: Bool = true, hideBar: Bool = false, hideBottomBar: Bool = false, completion: (() -> Void)? = nil) {
        guard
            let controller = module?.toPresent(),
            (controller is UINavigationController == false)
            else { assertionFailure("Deprecated push UINavigationController."); return }
        
        if let completion = completion {
            self.completions[controller] = completion
        }
        controller.hidesBottomBarWhenPushed = hideBottomBar
        if hideBar {
            self.rootController?.isNavigationBarHidden = true
            self.rootController?.interactivePopGestureRecognizer?.isEnabled = true
            self.rootController?.interactivePopGestureRecognizer?.delegate = nil
        } else {
            self.rootController?.isNavigationBarHidden = false
            self.rootController?.interactivePopGestureRecognizer?.isEnabled = false
        }
        self.rootController?.pushViewController(controller, animated: animated)
    }
    
    func popModule(animated: Bool = true)  {
        if let controller = self.rootController?.popViewController(animated: animated) {
            self.runCompletion(for: controller)
        }
    }
    
    func popToModule(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        if let controllers = self.rootController?.popToViewController(controller, animated: animated) {
            controllers.forEach { controller in
                self.runCompletion(for: controller)
            }
        }
    }
    
    func setRootModule(_ module: Presentable?, hideBar: Bool = false, animation: Animation? = .fadeIn) {
        guard let controller = module?.toPresent() else { return }
        self.rootController?.setViewControllers([controller], animated: false)
        self.rootController?.isNavigationBarHidden = hideBar
        
        switch animation {
        case .fadeIn:
            self.fadeAnimation(0.3)
        case .bottomUp:
            self.bottomUpAnimation()
        case .topDown:
            self.topDownAnimation()
        default:
            break
        }
    }
    
    private func fadeAnimation(_ duration: CGFloat) {
        let transition = CATransition()
        transition.duration = CFTimeInterval(duration);
        transition.type = CATransitionType.fade;
        transition.subtype = CATransitionSubtype.fromTop;
        self.rootController?.view.layer.add(transition, forKey: kCATransition)
    }
    
    private func bottomUpAnimation() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromTop
        self.rootController?.view.layer.add(transition, forKey: nil)
    }
    
    private func topDownAnimation() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromBottom
        self.rootController?.view.layer.add(transition, forKey: nil)
    }
    
    func popToRootModule(animated: Bool) {
        if let controllers = rootController?.popToRootViewController(animated: false) {
            controllers.forEach { controller in
                runCompletion(for: controller)
            }
        }
    }
    
    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
    
    enum Animation {
        case fadeIn
        case bottomUp
        case topDown
    }
    
    enum PresentMode {
        case overContext
        case fullScreen
        case basic
    }
}

protocol Presentable {
    func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {
    func toPresent() -> UIViewController? {
        return self
    }
}
