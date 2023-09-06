//
//  DogsVM.swift
//  Cats
//
//  Created by Ridwan Abdurrasyid on 06/09/23.
//

import UIKit

class DogsVM: BaseVM {
    var textAPI: DogsAPI!
    var imageAPI: DogsImageAPI!
    
    var onImageReceived: ((UIImage) -> Void)?
    var onTextReceived: ((String) -> Void)?
    
    func fetch() {
        self.fetchImage()
        self.fetchText()
    }
    
    func fetchImage() {
        self.imageAPI.fetch { image in
            self.onImageReceived?(image)
        }
    }
    
    func fetchText() {
        self.textAPI.fetch { model in
            self.onTextReceived?(model.facts.first ?? "")
        }
    }
}
