//
//  MockApiService.swift
//  SwaggerTests
//
//  Created by Patrick on 23.02.2023..
//

import Foundation
@testable import Swagger

class MockAPIService: APIService {

    override func login(_ model: LoginRequestModel) {
        guard model.email != "",
              model.password != "",
              model.appId != "" else {fatalError("Missing credentials for login")}

        token = UUID().uuidString
        UserDefaults.standard.set(token, forKey: "AccessToken")
    }
}
