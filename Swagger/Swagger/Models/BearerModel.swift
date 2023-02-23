//
//  BearerModel.swift
//  Swagger
//
//  Created by Patrick on 22.02.2023..
//

import Foundation

/// - BearerModel:
/// Codable structure to create JSON authorization header with recieved accessToken.
/// - Parameter key: String with a value "Authorization" as the required value for successful authorization.
/// - Parameter value: String as a combination of "Bearer" key and recieved access token

struct BearerModel: Codable {
    var key: String
    var value: String

    init(_ description: String) {
        key = "Authorization"
        value = "Bearer \(description)"
    }
}
