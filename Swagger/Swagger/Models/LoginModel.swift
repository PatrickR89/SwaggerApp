//
//  LoginModel.swift
//  Swagger
//
//  Created by Patrick on 22.02.2023..
//

import Foundation

/// Codable Structure defining values required for encoding body for  valid HTTP request to given API.
/// - Parameter email: given by user input
/// - Parameter password: given by user input
/// - Parameter appId: defined as a static constant in ``APIConstants``

struct LoginRequestModel: Codable {
    let email: String
    let password: String
    let appId: String
}

/// Codable Structure defining schema for JSON decoding HTTP response with required token for further app actions.
///  - Parameter accessToken: Required token
///  - Parameter username: unused in this application
///  - Parameter refreshToken: unused in this application

struct LoginResponseModel: Codable {
    let username: String
    let accessToken: String
    let refreshToken: String
}
