//
//  ProfileUseCasePlatform.swift
//  Dota2Dictionary
//
//  Created by MacOS on 18/11/2021.
//

import Foundation
import RxSwift
import Firebase

class ProfileUseCasePlatform: ProfileUseCaseDomain {
    func signout() {
        try? Auth.auth().signOut()
    }
    
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
    
    func loadLikedHero() -> Observable<[HeroLikedModel]> {
        return Observable.create { (observer) -> Disposable in
            let ref = Database.database().reference()
            var listLikedHero = [HeroLikedModel]()
            Auth.auth().addStateDidChangeListener { _, user in
                if let user = user {
                    let newRef = ref.child("liked").child(user.uid).queryOrdered(byChild: "timestamp")
                    newRef.observe(.value) { (snapshot) in
                        listLikedHero.removeAll()
                        for case let child as DataSnapshot in snapshot.children {
                            guard let dict = child.value as? [String: Any] else {
                                observer.onNext(listLikedHero)
                                return
                            }
                            let likedHero = HeroLikedModel(dict: dict)
                            listLikedHero.append(likedHero)
                        }
                        observer.onNext(listLikedHero)
                    }
                }
            }
            return Disposables.create()
        }
    }
}
