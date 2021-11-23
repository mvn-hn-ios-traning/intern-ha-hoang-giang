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
                                    authData?.user.sendEmailVerification(completion: { (error) in
                                        if error != nil {
                                            observer.onNext(error!.localizedDescription)
                } else {
                    observer.onNext("Sent verification email")
                    if let userData = authData {
                        let imageName = userData.user.uid
                        if let imageUpload = avatar {
                            if let imgData = imageUpload.jpegData(compressionQuality: 0.25) {
                                let storageRef = Storage.storage().reference()
                                let uploadStorage = storageRef.child("Avatar").child(imageName)
                                uploadStorage.putData(imgData,
                                                      metadata: nil,
                                                      completion: { (_, error) in
                                                        if error != nil {
                                                            observer.onNext(error!.localizedDescription)
                                                        } else {
                                                            observer.onNext("Uploaded avatar success")
                                                            // downloading image after uploading
                                                            uploadStorage.downloadURL(completion: { (url, error) in
                                                                if error != nil {
                                                                    observer.onNext(error!.localizedDescription)
                                                                } else {
                                                                    // Save url in database
                                                                    guard let avatarUrl = url else {return}
                                                                    let databaseRef = Database.database().reference()
                                                                    let value: [String: Any] = [
                                                                        "avatar": "\(avatarUrl)",
                                                                        "firstName": firstName,
                                                                        "lastName": lastName,
                                                                        "email": email,
                                                                        "id": userData.user.uid
                                                                    ]
                                                                    databaseRef
                                                                        .child("User")
                                                                        .child(userData.user.uid)
                                                                        .setValue(value)
                                                                }
                                                            })
                                                        }
                                })
                            }
                        }
                    }
                }
                                })
            }
            return Disposables.create()
        }
    }
    
}
