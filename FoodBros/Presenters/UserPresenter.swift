//
//  UserPresenter.swift
//  FoodBros
//
//  Created by Rifluxyss on 12/09/25.
//

import Foundation

struct UserPresenter {
    
    func isValidUser(user: CreateUser, completion: @escaping (_ success: Bool) -> Void) {
        UserService().isValidUser(user: user, completion: completion)
    }
    
    func createUser(user: CreateUser) {
        UserService().createUser(user: user)
    }
}
