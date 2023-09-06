//
//  DogsVC.swift
//  Cats
//
//  Created by Ridwan Abdurrasyid on 06/09/23.
//

import UIKit

class DogsVC: CatsVC {
    var dogsViewModel: DogsVM!
    
    override func setupVM() {
        self.dogsViewModel.onTextReceived = { text in
            DispatchQueue.main.async {
                self.factLabel.change(to: "\"\(text)\"")
            }
        }
        self.dogsViewModel.onImageReceived = { image in
            DispatchQueue.main.async {
                self.animalImage.change(to: image)
                self.nextButton.enableButton()
            }
        }
    }
    
    @objc override func fetchVM() {
        self.nextButton.disableButton()
        self.dogsViewModel.fetch()
    }
    
    override func setupButton() {
        self.nextButton.setTitle("More Dog Facts?", for: .normal)
        self.nextButton.addTarget(self, action: #selector(fetchVM), for: .touchUpInside)
    }
}
