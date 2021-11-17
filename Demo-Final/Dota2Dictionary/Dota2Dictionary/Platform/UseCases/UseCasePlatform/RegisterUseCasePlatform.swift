//
//  RegisterUseCasePlatform.swift
//  Dota2Dictionary
//
//  Created by MacOS on 17/11/2021.
//

import Foundation
import RxSwift
import Firebase

class RegisterUseCasePlatform: RegisterUseCaseDomain {
    func register(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (authData, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            authData?.user.sendEmailVerification(completion: { (error) in
                if error != nil {
                    print(error!.localizedDescription)
                } else {
                    print("Sent verification email")
                }
            })
        }
    }
}
