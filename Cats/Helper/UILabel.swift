//
//  UILabel.swift
//  Cats
//
//  Created by Ridwan Abdurrasyid on 06/09/23.
//

import UIKit

extension UILabel {
    func change(to text: String) {
        UIView.transition(with: self,
                          duration: 0.50,
                          options: .transitionCrossDissolve,
                          animations: { self.text = text },
                          completion: nil)
    }
}
