//
//  DatabaseManager.swift
//  Dota2Dictionary
//
//  Created by MacOS on 21/11/2021.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
}

// MARK: - Account Manager
extension DatabaseManager {
    // insert new user to database
    public func insertUser(with user: User,
                           completion: @escaping (Bool) -> Void) {
        database.child(user.safeEmail).setValue([
            "firstName": user.firstName,
            "lastName": user.lastName
            ], withCompletionBlock: { (error, _) in
                guard error == nil else {
                    print("failed to write to database")
                    completion(false)
                    return
                }
                completion(true)
        })
    }
}

struct User {
    let firstName: String
    let lastName: String
    let emailAddress: String
    
    var safeEmail: String {
        let safeEmail = emailAddress
            .replacingOccurrences(of: "@", with: "-")
            .replacingOccurrences(of: ".", with: "-")
        return safeEmail
    }
    
    var profilePictureFileName: String {
       // /images/giang113-gmail-com_profile_picture_png
        return "\(safeEmail)_profile_picture_png"
    }
}
