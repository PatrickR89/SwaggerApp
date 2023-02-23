//
//  UserResponse.swift
//  Swagger
//
//  Created by Patrick on 22.02.2023..
//

import Foundation

struct UserResponse: Codable {
    let id: Int
    let name: String
    let surname: String
    let fullName: String
    let imageId: Int
    let adress: String
    let phonenumber: String
    let oib: String
    let email: String
    let statusId: Int

    init(id: Int, name: String?,
         surname: String?, fullName: String?,
         imageId: Int?, adress: String?,
         phonenumber: String?, oib: String?,
         email: String?, statusId: Int) {

        self.id = id
        self.name = name ?? "Nepoznato"
        self.surname = surname ?? "Nepoznato"
        self.fullName = fullName ?? "Nepoznato"
        self.imageId = imageId ?? -1
        self.adress = adress ?? "Nepoznato"
        self.phonenumber = phonenumber ?? "Nepoznato"
        self.oib = oib ?? "Nepoznato"
        self.email = email ?? "Nepoznato"
        self.statusId = statusId
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
