//
//  CreateUser.swift
//  FoodBros
//
//  Created by Rifluxyss on 12/09/25.
//

import Foundation

struct CreateUser: Codable {
    let fullName: String
    let username: String?
    let email: String?
    let passwordHash: String?
    let phoneNumber: String?
}

struct IsValidUser: Codable {
    let username: Bool
    let email: Bool
    let phoneNumber: Bool
    
    var isValid: Bool {
        return username && email && phoneNumber
    }
}
