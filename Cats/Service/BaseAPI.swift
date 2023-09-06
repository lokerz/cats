//
//  BaseAPI.swift
//  Cats
//
//  Created by Ridwan Abdurrasyid on 31/08/23.
//

import Foundation

protocol BaseAPI {
    var url: String { get }
    var method: HTTPMethod { get }
}
