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
    func service(didRecieve errorMessage: String)
}

protocol APIServiceActions: AnyObject {
    func service(didRecieve userData: UserResponseFiltered)
}

class APIService: NSObject {

    @Published var token: String?

    private(set) var inRequest = false
    weak var delegate: APIServiceDelegate?
    weak var actions: APIServiceActions?

    override init() {
        super.init()
        self.token = UserDefaults.standard.string(forKey: "AccessToken")
    }

    func login(_ model: LoginRequestModel) {

        let url = URL(string: "\(APIConstants.apiUrl)\(APIConstants.loginApi)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(model)
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        request.timeoutInterval = 5

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in

            guard error == nil else {
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.service(isWaiting: false)
                    self?.delegate?.service(didRecieve: error!.localizedDescription)
                }

                return
            }

            guard let response = response as? HTTPURLResponse else { return }
            guard response.statusCode == 200 else {
                if response.statusCode == 403 || response.statusCode == 401 {
                    self?.delegate?.service(didRecieve: "Neispravan e-mail i/ili lozinka")
                } else if response.statusCode >= 400 && response.statusCode < 500 {
                    self?.delegate?.service(didRecieve: "Greška u zahtjevu")
                } else if response.statusCode >= 500 {
                    self?.delegate?.service(didRecieve: "Greška u serveru")
                }
                self?.delegate?.service(isWaiting: false)
                return
            }

            guard let data = data else {return}
            guard let respData = try? JSONDecoder().decode(LoginResponseModel.self, from: data) else {return}
            self?.token = respData.accessToken
            let userDefaults = UserDefaults.standard
            userDefaults.set(respData.accessToken, forKey: "AccessToken")

            self?.delegate?.service(isWaiting: false)
            self?.fetchUserData()
        }

        delegate?.service(isWaiting: true)
        task.resume()
    }

    func fetchUserData() {
        let url = URL(string: "\(APIConstants.apiUrl)\(APIConstants.fetchUserApi)")!
        guard let token = token else {
            return
        }

        let bearer = BearerModel(token)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [bearer.key: bearer.value, "Accept": "*/*", "Content-Type": "application/json"]
        request.timeoutInterval = 5

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard error == nil else {
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.service(isWaiting: false)
                    self?.delegate?.service(didRecieve: error!.localizedDescription)
                }

                return
            }

            guard let response = response as? HTTPURLResponse else { return }
            guard response.statusCode == 200 else {
                if response.statusCode >= 400 && response.statusCode < 500 {
                    self?.delegate?.service(didRecieve: "Greška u zahtjevu")
                } else if response.statusCode >= 500 {
                    self?.delegate?.service(didRecieve: "Greška u serveru")
                }
                self?.delegate?.service(isWaiting: false)
                return
            }

            guard let data = data else {return}
            guard let respData = try? JSONDecoder().decode(UserResponse.self, from: data) else {return}
            self?.delegate?.service(isWaiting: false)
            let filtered = UserResponseFiltered(user: respData)
            DispatchQueue.main.async {
                self?.actions?.service(didRecieve: filtered)
            }
        }

        delegate?.service(isWaiting: true)
        task.resume()
    }
}

extension APIService: LoginControllerActions {
    func loginController(didRequestLoginFor user: String, with password: String) {
        let loginModel = LoginRequestModel(email: user, password: password, appId: APIConstants.appId)
        login(loginModel)
    }
}
