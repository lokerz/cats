//
//  DogsAPI.swift
//  Cats
//
//  Created by Ridwan Abdurrasyid on 06/09/23.
//

import Foundation

class DogsAPI: BaseAPI {
    var url = "https://dog-api.kinduff.com/api/facts"
    var method = HTTPMethod.GET
    
    func fetch(completion: @escaping ((DogsModel) -> Void)) {
        Connection.shared.connect(url: url, method: method) { result in
            switch result {
            case .success (let data) :
                if let response = data.decode(type: DogsModel.self) {
                    completion(response)
                }
            case .error (let message, let status) :
                AlertManager.shared.showAlert(status: status, message: message)
            }
        }
    }
}
