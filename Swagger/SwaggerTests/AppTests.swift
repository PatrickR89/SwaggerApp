//
//  AppTests.swift
//  SwaggerTests
//
//  Created by Patrick on 23.02.2023..
//

import XCTest
@testable import Swagger
import Combine

final class AppTests: XCTestCase {

    private var mainCoordinator: MainCoordinator?
    private var apiService: MockAPIService?
    private var cancellables = Set<AnyCancellable>()

    override func setUp() {
        apiService = MockAPIService()
        mainCoordinator = MainCoordinator(UINavigationController(), apiService!)

    }

    override func tearDown() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(nil, forKey: "AccessToken")
        mainCoordinator = nil
        cancellables = []
    }

    func testLogin() {
        guard let loginController = mainCoordinator?.loginController else {
            fatalError("Login controller did not initialize!")
        }

        loginController.editUserCredentials(.email, "someexample@some.com")
        loginController.editUserCredentials(.password, "someString")
        loginController.requestLogin()
        let expectation = XCTestExpectation(description: "Expect non nil token")

        mainCoordinator?.apiService.$token.sink(receiveValue: { token in
            XCTAssertNotNil(token)
            XCTAssertNotNil(UserDefaults.standard.string(forKey: "AccessToken"))

            expectation.fulfill()
        }).store(in: &cancellables)

        wait(for: [expectation], timeout: 3)

    }

    func testFetchData() {

        apiService?.fetchUserData()
        let expectation = XCTestExpectation(description: "Fetch user data")
        guard let detailsController = mainCoordinator?.detailsController else {
            fatalError("Details Controller did not initialize")
        }
        detailsController.$details.sink(receiveValue: { details in
            XCTAssertFalse(details.isEmpty)
            expectation.fulfill()
        }).store(in: &cancellables)

        wait(for: [expectation], timeout: 10)
    }
}
