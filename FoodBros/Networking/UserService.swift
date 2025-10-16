//
//  UserService.swift
//  FoodBros
//
//  Created by Rifluxyss on 12/09/25.
//

import Foundation

struct UserService {
    func isValidUser( user: CreateUser, completion: @escaping (_ success: Bool) -> Void) {
        WebService()
            .setPath(path: "users/isValidUser")
            .setMethod(.post)
            .setBody(user)
            .build(type: IsValidUser.self) { responseBody, error in
                if let error = error {
                    print("Error:", error)
                    completion(false)
                } else if let response = responseBody as? IsValidUser {
                    completion(response.isValid)
                } else {
                    completion(false)
                }
            }
    }
    
    func createUser(user: CreateUser) {
        WebService()
            .setPath(path: "users/registerUser")
            .setMethod(.post)
            .setBody(user)
            .build { response, error in
                if let error = error {
                    print("Error:", error)
                } else {
                    print("Response:", response ?? "")
                }
            }
    }
}
