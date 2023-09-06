//
//  Connection.swift
//  Cats
//
//  Created by Ridwan Abdurrasyid on 06/09/23.
//

import Foundation
import UIKit

enum APICompletion {
    case success (data: Data)
    case error (message: String, statusCode: Int)
}

class Connection {
    static let shared = Connection()
    
    func connect(url: String, method: HTTPMethod, completion: @escaping (APICompletion) -> Void) {
        let url = URL(string: url)
        var statusCode = -1
        
        // Checks nullability
        if let _url = url {
            var urlRequest = URLRequest(url: _url)
            urlRequest.httpMethod = method.rawValue
            
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
                // Possible Crash
                if error != nil {
                    completion(.error(message: error?.localizedDescription ?? "Error", statusCode: statusCode))
                    return
                }
                
                // Possible Crash : Response not found
                else if response == nil {
                    completion(.error(message: error?.localizedDescription ?? "Retrieve response failed.", statusCode: statusCode))
                    return
                }
                
                // Possible Crash : Data not found
                else if data == nil {
                    completion(.error(message: error?.localizedDescription ?? "Retrieve data failed", statusCode: statusCode))
                    return
                }
                
                // Possible Crash : Status > 200
                else if let httpResponse = response as? HTTPURLResponse, let data_ = data {
                    statusCode = httpResponse.statusCode
                    if httpResponse.statusCode > 200 , let response = data_.decode(type: BaseModel.self){
                        completion(.error(message: response.message ?? "Error Unknown", statusCode: httpResponse.statusCode))
                    } else if httpResponse.statusCode > 200  {
                        completion(.error(message: "Something went wrong", statusCode: httpResponse.statusCode))
                    }
                }

                if let data_ = data {
                    // All case failed to retrieve error
                    completion(.success(data: data_))
                }
            }.resume()
        }
    }
}

extension Data {
    func decode<T: Decodable>(type: T.Type) -> T? {
        do {
            let responseBody = try JSONDecoder().decode(T.self, from: self)
            return responseBody
        }
        catch {
            AlertManager.shared.showAlert(status: 0, message: "Decode Failed")
        }
        return nil
    }
}

enum HTTPMethod: String {
    case GET
    case HEAD
    case POST
    case PUT
    case DELETE
    case CONNECT
    case OPTIONS
    case TRACE
    case PATCH
}
