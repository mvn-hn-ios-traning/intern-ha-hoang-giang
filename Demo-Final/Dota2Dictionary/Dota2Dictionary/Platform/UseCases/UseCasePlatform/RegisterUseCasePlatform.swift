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
    
    func register(avatar: UIImage?,
                  firstName: String,
                  lastName: String,
                  email: String,
                  password: String) -> Observable<String> {
        return Observable<String>.create { (observer) -> Disposable in
            
            Auth.auth().createUser(withEmail: email, password: password) { (authData, error) in
                if error != nil {
                    observer.onNext(error!.localizedDescription)
                    //                }
                    //                authData?.user.sendEmailVerification(completion: { (error) in
                    //                    if error != nil {
                    //                        observer.onNext(error!.localizedDescription)
                } else {
                    observer.onNext("Sent verification email")
                    if let userData = authData {
                        let imageName = userData.user.uid
                        if let imageUpload = avatar {
                            if let imgData = imageUpload.jpegData(compressionQuality: 0.5) {
                                let storageRef = Storage.storage().reference()
                                let uploadStorage = storageRef.child("Avatar").child(imageName)
                                uploadStorage.putData(imgData,
                                                      metadata: nil,
                                                      completion: { (_, error) in
                                                        if error != nil {
                                                            observer.onNext(error!.localizedDescription)
                                                            print("putData failed: \(error!.localizedDescription)")
                                                        } else {
                                                            observer.onNext("Uploaded avatar success")
                                                        }
                                })
                            }
                        }
                    }
                }
                //                })
            }
            return Disposables.create()
        }
    }
    
}
