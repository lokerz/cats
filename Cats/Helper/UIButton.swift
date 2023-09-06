//
//  UIButton.swift
//  Cats
//
//  Created by Ridwan Abdurrasyid on 06/09/23.
//

import UIKit

extension UIButton {
    func disableButton(radius: CGFloat = 30) {
        self.layer.cornerRadius = radius
        self.backgroundColor = UIColor.lightGray
        self.setTitleColor(.white, for: .normal)
        self.isUserInteractionEnabled = false
    }
    
    func enableButton(color: UIColor = UIColor.systemCyan, radius: CGFloat = 30) {
        self.layer.cornerRadius = radius
        self.backgroundColor = color
        self.isUserInteractionEnabled = true
    }
}
