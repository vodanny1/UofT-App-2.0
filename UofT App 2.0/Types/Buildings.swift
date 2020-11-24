//
//  Buildings.swift
//  UofT App 2.0
//
//  Created by Danny Vo on 2020-11-24.
//

import Foundation

struct BuildingResponse: Codable {
    let response: [BuildingResult]
    let status_code: Int
    let status_message: String
}

struct BuildingResult: Codable {
    let id: String
    let code: String
    let tags: String?
    let name: String
    let short_name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
    let province: String
    let country: String
    let postal: String?
}
