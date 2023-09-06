//
//  CatsImageAPI.swift
//  Cats
//
//  Created by Ridwan Abdurrasyid on 06/09/23.
//

import Foundation
import UIKit

class CatsImageAPI: BaseAPI {
    var url = "https://cataas.com/cat"
    var method = HTTPMethod.GET
    
    func fetch(completion: @escaping ((UIImage) -> Void)) {
        Connection.shared.connect(url: url, method: method) { result in
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
}
