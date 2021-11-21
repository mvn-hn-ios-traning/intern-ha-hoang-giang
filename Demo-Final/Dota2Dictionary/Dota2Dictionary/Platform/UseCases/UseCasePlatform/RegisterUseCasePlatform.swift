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
    
    func register(firstName: String,
                  lastName: String,
                  email: String,
                  password: String) -> Observable<String> {
        return Observable<String>.create { (observer) -> Disposable in
            
            DatabaseManager.shared.userExists(with: email) { (exist) in
                guard exist == false else {
                    // user already exists
                    observer.onNext("Look like a user account for that email address already exists")
                    return
                }
                
                Auth.auth().createUser(withEmail: email, password: password) { (authData, error) in
                    if error != nil {
                        observer.onNext(error!.localizedDescription)
                        //                }
                        //                authData?.user.sendEmailVerification(completion: { (error) in
                        //                    if error != nil {
                        //                        observer.onNext(error!.localizedDescription)
                    } else {
                        observer.onNext("Sent verification email")
                        
                        DatabaseManager.shared.insertUser(with: User(firstName: firstName,
                                                                     lastName: lastName,
                                                                     emailAddress: email))
                        
                    }
                    //                })
                }
                
            }
            return Disposables.create()
        }
    }
    
}
