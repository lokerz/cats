//
//  DogsImageAPI.swift
//  Cats
//
//  Created by Ridwan Abdurrasyid on 06/09/23.
//

import Foundation
import UIKit

class DogsImageAPI: BaseAPI {
    var url = "https://dog.ceo/api/breeds/image/random"
    var method = HTTPMethod.GET
    
    func fetch(completion: @escaping ((UIImage) -> Void)) {
        Connection.shared.connect(url: self.url, method: self.method) { result in
            switch result {
            case .success (let data) :
                if let response = data.decode(type: DogsImageModel.self) {
                    Connection.shared.connect(url: response.message, method: self.method) { result in
                        switch result {
                        case .success (let data) :
                            if let response = UIImage(data: data) {
                                completion(response)
                            }
                        case .error (let message, let status) :
                            AlertManager.shared.showAlert(status: status, message: message)
                        }
                    }
                }
            case .error (let message, let status) :
                AlertManager.shared.showAlert(status: status, message: message)
            }
        }
    }
}
