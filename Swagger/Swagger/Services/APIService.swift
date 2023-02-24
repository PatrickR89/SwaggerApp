//
//  APIService.swift
//  Swagger
//
//  Created by Patrick on 22.02.2023..
//

import Foundation
import Combine

/// Protocol containing functions called from ``APIService``, with the destination of ``LoginController``
protocol APIServiceDelegate: AnyObject {
    /// Delegate method used to report if ``APIService`` is waiting for response upon sent request.
    /// - Parameter isWaiting: Boolean value to define state and trigger affected elements.
    func service(isWaiting: Bool)
    /// Delegate method used to proceed with recieved error messages.
    /// - Parameter errorMessage: String with value of either localized description of recieved error or defined by recieved codes in response if not 200.
    func service(didRecieve errorMessage: String)
}

/// APIService protocol with the target of ``MainCoordinator`` providing recieved data
protocol APIServiceActions: AnyObject {
    /// Protocol method to forward recieved data.
    /// - Parameter userData: Decoded data from HTTP response
    func service(didRecieve userData: UserResponse)
}

/// Class containing all HTTP requests and JSON codings, in order to centralize methods with same purpose/goal.
/// Class contains an optional published token, for future requests and test cases.
class APIService: NSObject {

    @Published var token: String?

    weak var delegate: APIServiceDelegate?
    weak var actions: APIServiceActions?

    override init() {
        super.init()
        self.token = UserDefaults.standard.string(forKey: "AccessToken")
    }

    /// Encodes recieved model to JSON, attaching it to URLRequest, with required headers. Sends the request to designated API, awaiting response with required token
    /// - Parameter model: ``LoginRequestModel`` recieved from ``LoginController``

    func login(_ model: LoginRequestModel) {

        let url = URL(string: "\(APIConstants.apiUrl)\(APIConstants.loginApi)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(model)
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        request.timeoutInterval = 5

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in

            if let error = error {
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.service(isWaiting: false)
                    self?.delegate?.service(didRecieve: error.localizedDescription)
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

            guard let data = data else {
                self?.delegate?.service(didRecieve: "Greška u preuzimanju tokena")
                self?.delegate?.service(isWaiting: false)
                return
            }
            guard let respData = try? JSONDecoder().decode(LoginResponseModel.self, from: data) else {
                self?.delegate?.service(didRecieve: "Greška u preuzimanju tokena")
                self?.delegate?.service(isWaiting: false)
                return
            }
            self?.token = respData.accessToken
            let userDefaults = UserDefaults.standard
            userDefaults.set(respData.accessToken, forKey: "AccessToken")

            self?.delegate?.service(isWaiting: false)
            self?.fetchUserData()
        }

        delegate?.service(isWaiting: true)
        task.resume()
    }

    /// Method sends HTTP request with required authorization token in header, in order to recieve data.
    /// Recieved data is decoded from JSON and sent via ``APIServiceActions``.

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
            if let error = error {
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.service(isWaiting: false)
                    self?.delegate?.service(didRecieve: error.localizedDescription)
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

            guard let data = data else {
                self?.delegate?.service(didRecieve: "Greška u preuzimanju podataka")
                self?.delegate?.service(isWaiting: false)
                return
            }
            guard let respData = try? JSONDecoder().decode(UserResponse.self, from: data) else {
                self?.delegate?.service(didRecieve: "Greška u preuzimanju podataka")
                self?.delegate?.service(isWaiting: false)
                return
            }
            self?.delegate?.service(isWaiting: false)
            DispatchQueue.main.async {
                self?.actions?.service(didRecieve: respData)
            }
        }

        delegate?.service(isWaiting: true)
        task.resume()
    }
}

extension APIService: LoginControllerActions {
    /// Delegate method from ``LoginController`` triggered upon interaction with `submitButton` placed in ``LoginView``
    /// - Parameters:
    ///   - user: String value recieved from `usernameInput` in ``LoginView``
    ///   - password: String value recieved from `passwordInput` in ``LoginView``
    func loginController(didRequestLoginFor user: String, with password: String) {
        let loginModel = LoginRequestModel(email: user, password: password, appId: APIConstants.appId)
        login(loginModel)
    }
}
