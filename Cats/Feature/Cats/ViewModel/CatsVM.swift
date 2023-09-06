//
//  CatsVM.swift
//  Cats
//
//  Created by Ridwan Abdurrasyid on 31/08/23.
//

import UIKit

class CatsVM: BaseVM {
    var textAPI: CatsAPI!
    var imageAPI: CatsImageAPI!
    
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
            self.onTextReceived?(model.fact)
        }
    }
}
