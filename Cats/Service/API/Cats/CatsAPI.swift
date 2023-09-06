//
//  CatsAPI.swift
//  Cats
//
//  Created by Ridwan Abdurrasyid on 06/09/23.
//

import Foundation

class CatsAPI: BaseAPI {
    var url = "https://catfact.ninja/fact"
    var method = HTTPMethod.GET
    
    func fetch(completion: @escaping ((CatsModel) -> Void)) {
        Connection.shared.connect(url: url, method: method) { result in
            switch result {
            case .success (let data) :
                if let response = data.decode(type: CatsModel.self) {
                    completion(response)
                }
            case .error (let message, let status) :
                AlertManager.shared.showAlert(status: status, message: message)
            }
        }
    }
}
