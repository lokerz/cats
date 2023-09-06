//
//  UIImageView.swift
//  Cats
//
//  Created by Ridwan Abdurrasyid on 06/09/23.
//

import UIKit

extension UIImageView {
    func change(to image: UIImage) {
        UIView.transition(with: self,
                          duration: 0.50,
                          options: .transitionCrossDissolve,
                          animations: { self.image = image },
                          completion: nil)
    }
}
