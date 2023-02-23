//
//  LoginModel.swift
//  Swagger
//
//  Created by Patrick on 22.02.2023..
//

import Foundation

struct LoginRequestModel: Codable {
    let email: String
    let password: String
    let appId: String
}

struct LoginResponseModel: Codable {
    let username: String
    let accessToken: String
    let refreshToken: String
}
