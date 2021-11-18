//
//  LoginUseCasePlatform.swift
//  Dota2Dictionary
//
//  Created by MacOS on 17/11/2021.
//

import Foundation
import RxSwift
import Firebase

class LoginUseCasePlatform: LoginUseCaseDomain {
    func login(email: String, password: String) -> Observable<String> {
        return Observable<String>.create { (observer) -> Disposable in
            Auth.auth().signIn(withEmail: email, password: password) { (authData, error) in
                if error != nil {
                    observer.onNext(error!.localizedDescription)
                } else {
                    if (authData?.user.isEmailVerified) == true {
                        observer.onNext("Login successfully")
                    } else {
                        observer.onNext("Your account have not verified yet")
                    }
                }
            }
            return Disposables.create()
        }
    }
    
    func resetPassword(email: String) -> Observable<String> {
        return Observable<String>.create { (observer) -> Disposable in
            Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                if error != nil {
                    observer.onNext(error!.localizedDescription)
                } else {
                    observer.onNext("Please check your email to change password")
                }
            }
            return Disposables.create()
        }
    }
    
}
