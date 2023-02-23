//
//  APIService.swift
//  Swagger
//
//  Created by Patrick on 22.02.2023..
//

import Foundation
import Combine

protocol APIServiceDelegate: AnyObject {
    func service(isWaiting: Bool)
}

class APIService: NSObject {

    @Published var token: String?

    private(set) var inRequest = false
    weak var delegate: APIServiceDelegate?

    override init() {
        super.init()
        self.token = UserDefaults.standard.string(forKey: "AccessToken")
    }

    func login(_ model: LoginRequestModel) {

        let url = URL(string: "\(APIConstants.apiUrl)\(APIConstants.loginApi)")!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(model)
        request.timeoutInterval = 5

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in

            guard error == nil else {
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.service(isWaiting: true)

                }

                return
            }

            guard let data = data else {return}

            guard let respData = try? JSONDecoder().decode(LoginResponseModel.self, from: data) else {return}
            self?.token = respData.accessToken
            let userDefaults = UserDefaults.standard
            userDefaults.set(respData.accessToken, forKey: "AccessToken")

            self?.delegate?.service(isWaiting: false)
        }

        delegate?.service(isWaiting: true)

//        task.resume()
    }
}

extension APIService: LoginControllerActions {
    func loginController(didRequestLoginFor user: String, with password: String) {
        let loginModel = LoginRequestModel(email: user, password: password, appId: APIConstants.appId)
        login(loginModel)
    }
}
