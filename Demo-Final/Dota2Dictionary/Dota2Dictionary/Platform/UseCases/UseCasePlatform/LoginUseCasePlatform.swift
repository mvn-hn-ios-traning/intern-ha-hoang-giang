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
