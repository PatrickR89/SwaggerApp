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

    override func fetchUserData() {
        let testData = UserResponse(id: 22, name: "asd", surname: "asd", fullName: nil, imageId: nil, adress: "asd", phonenumber: "dfsf", oib: nil, email: "asdasd", statusId: 99)

        self.actions?.service(didRecieve: UserResponseFiltered(user: testData))
    }
}
