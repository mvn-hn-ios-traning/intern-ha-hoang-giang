//
//  User.swift
//  Dota2Dictionary
//
//  Created by MacOS on 23/11/2021.
//

import Foundation

class User {
    var avatar: String
    var firstName: String
    var lastName: String
    var email: String
    var id: String
    
    init(dict: [String: Any]) {
        self.avatar = dict["avatar"] as? String ?? ""
        self.firstName = dict["firstName"] as? String ?? ""
        self.lastName = dict["lastName"] as? String ?? ""
        self.email = dict["email"] as? String ?? ""
        self.id = dict["id"] as? String ?? ""
    }
}
