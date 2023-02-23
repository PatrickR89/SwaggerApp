//
//  BearerModel.swift
//  Swagger
//
//  Created by Patrick on 22.02.2023..
//

import Foundation

struct BearerModel: Codable {
    var key: String
    var value: String

    init(_ description: String) {
        key = "Authorization"
        value = "Bearer \(description)"
    }
}
