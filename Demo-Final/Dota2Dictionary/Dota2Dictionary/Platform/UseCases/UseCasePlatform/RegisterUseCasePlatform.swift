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
                }
                authData?.user.sendEmailVerification(completion: { error in
                    if error != nil {
                        observer.onNext(error!.localizedDescription)
                    } else {
                        observer.onNext("Sent verification email")
                        
                        guard
                            let authData = authData,
                            let imageUpload = avatar
                            else {
                                print("profileImage = avatar error")
                                observer.onNext("profileImage = avatar error")
                                return
                        }
                        
                        let imageName = authData.user.uid
                        guard let imageData = imageUpload.jpegData(compressionQuality: 0.5) else {
                            return
                        }
                        let storageRef = Storage.storage().reference()
                        let uploadStorage = storageRef.child("Avatar").child(imageName)
                        uploadStorage.putData(imageData,
                                              metadata: nil,
                                              completion: { (_, error) in
                                                if error != nil {
                                                    print(error!.localizedDescription)
                                                } else {
                                                    uploadStorage.downloadURL(completion: changeProfile)
                                                }
                        })
                    }
                })
            }
            
            func changeProfile(url: URL?, error: Error?) {
                guard error == nil else { return }
                let changeRequest =
                    Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = firstName + " " + lastName
                changeRequest?.photoURL = url
                
                changeRequest?.commitChanges(completion: { error in
                    if error != nil {
                        observer.onNext(error!.localizedDescription)
                    } else {
                        observer.onNext("Successful")
                    }
                })
            }
            
            return Disposables.create()
        }
    }
    
}
