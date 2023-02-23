//
//  UserResponse.swift
//  Swagger
//
//  Created by Patrick on 22.02.2023..
//

import Foundation

/// - UserResponse:
/// Codable structure to be used as schema for JSON decoding values given by HTTP response.
/// Structure contains optional values as defined by given documentation.

struct UserResponse: Codable {
    let id: Int
    let name: String?
    let surname: String?
    let fullName: String?
    let imageId: Int?
    let adress: String?
    let phonenumber: String?
    let oib: String?
    let email: String?
    let statusId: Int
}
