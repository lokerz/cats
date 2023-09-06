//
//  UIView.swift
//  Cats
//
//  Created by Ridwan Abdurrasyid on 06/09/23.
//

import UIKit

extension UIView {
    func bindFrameToSuperviewBounds(top: CGFloat = 0,
                                    bottom: CGFloat = 0,
                                    left: CGFloat = 0,
                                    right: CGFloat = 0) {
        guard let superview = self.superview else {
            print("Error! `superview` was nil – call `addSubview(view: UIView)` before calling `bindFrameToSuperviewBounds()` to fix this.")
            return
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: top).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -bottom).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: left).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -right).isActive = true
    }
    
    func bindFrameToSafeBounds(top: CGFloat = 0,
                                    bottom: CGFloat = 0,
                                    left: CGFloat = 0,
                                    right: CGFloat = 0) {
        guard let superview = self.superview else {
            print("Error! `superview` was nil – call `addSubview(view: UIView)` before calling `bindFrameToSuperviewBounds()` to fix this.")
            return
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: top).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: -bottom).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: left).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: -right).isActive = true
    }
    
    func makeRounded(radius: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
    }
}
