//
//  LoginTests.swift
//  SwaggerTests
//
//  Created by Patrick on 24.02.2023..
//

import XCTest
@testable import Swagger
import Combine

final class LoginTests: XCTestCase {

    private(set) var loginViewController: LoginViewController?
    private(set) var loginController: LoginController?
    private(set) var cancellables = Set<AnyCancellable>()

    override func setUp() {
        self.loginController = LoginController()
        self.loginViewController = LoginViewController(loginController!)
        loginViewController?.loadView()
    }

    override func tearDown() {
        self.loginViewController = nil
        self.loginController = nil
        self.cancellables = []
    }

    func testEditUserCredentials() {
        guard let loginController = loginController else { fatalError("LoginController not initialized") }
        loginController.editUserCredentials(.email, "someexample@example.com")
        loginController.editUserCredentials(.password, "12345678")
        let emailExpectation = XCTestExpectation(description: "Expect change in email value")
        let passwordExpectation = XCTestExpectation(description: "Expect change in password value")

        loginController.$email
            .sink { email in
                XCTAssertTrue(email.count > 0)
                emailExpectation.fulfill()
            }
            .store(in: &self.cancellables)

        loginController.$password
            .sink { password in
                XCTAssertTrue(password.count > 0)
                passwordExpectation.fulfill()
            }
            .store(in: &self.cancellables)


        wait(for: [emailExpectation, passwordExpectation], timeout: 5)
    }

    func testPasswordVisibility() {
        guard let loginController = loginController else { fatalError("LoginController not initialized") }
        guard let loginView = loginViewController?.loginView else {fatalError("LoginViewController not initialized")}

        loginView.passwordInput.visibilityDelegate = loginController
        loginView.passwordInput.visibilityDelegate?.toggleVisibility()

        let expectation = XCTestExpectation(description: "Expect change in isPasswordVisible")

        loginController.$isPasswordVisible
            .sink { isVisible in
                XCTAssertFalse(isVisible)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 4)
    }
}
