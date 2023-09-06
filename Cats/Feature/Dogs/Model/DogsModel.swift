//
//  DogsModel.swift
//  Cats
//
//  Created by Ridwan Abdurrasyid on 06/09/23.
//

import Foundation

struct DogsModel: Decodable {
    let facts: [String]
}

struct DogsImageModel: Decodable {
    let message: String
}
