//
//  UserResponse.swift
//  Swagger
//
//  Created by Patrick on 22.02.2023..
//

import Foundation

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

struct UserResponseFiltered: Codable {
    let id: Int
    let name: String
    let surname: String
    let fullName: String
    let imageId: String
    let adress: String
    let phonenumber: String
    let oib: String
    let email: String
    let statusId: Int

    init(user: UserResponse) {

        self.id = user.id
        self.name = user.name ?? "Nepoznato"
        self.surname = user.surname ?? "Nepoznato"
        self.fullName = user.fullName ?? "Nepoznato"
        self.imageId = user.imageId == nil ? "Nepoznato" : "\(user.imageId!)"
        self.adress = user.adress ?? "Nepoznato"
        self.phonenumber = user.phonenumber ?? "Nepoznato"
        self.oib = user.oib ?? "Nepoznato"
        self.email = user.email ?? "Nepoznato"
        self.statusId = user.statusId
    }
}

enum UserProperties: String, CaseIterable {
    case id
    case name
    case surname
    case fullName
    case imageId
    case adress
    case phonenumber
    case oib
    case email
    case statusId
}
