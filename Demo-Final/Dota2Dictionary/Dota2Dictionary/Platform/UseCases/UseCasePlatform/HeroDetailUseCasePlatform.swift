//
//  HeroDetailUseCasePlatform.swift
//  Dota2Dictionary
//
//  Created by MacOS on 10/11/2021.
//

import Foundation
import RxSwift
import Firebase

// MARK: Hero Detail
class HeroDetailUseCasePlatform: HeroDetailUseCaseDomain {
    func loadHeroDetailDataAtFirst(heroID: String) -> Observable<HeroDetailModel> {
        return Observable.create { observer -> Disposable in
            let urlString = ConstantsForJsonUrl.heroDetailAllInfo
            
            HeroDetailAPISevice.shared.loadJson(fromURLString: urlString) { (result) in
                switch result {
                case .success(let data):
                    let data = HeroDetailAPISevice.shared.parseInfo(heroID: heroID, jsonData: data)
                    guard let newdata = data else { return }
                    observer.onNext(newdata)
                case .failure(let error):
                    print(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func loadHeroAbilityId(heroNameOriginal: String) -> Observable<HeroAbilityMidman> {
        return Observable.create { observer -> Disposable in
            let urlString = ConstantsForJsonUrl.heroAbilitiesId
            
            HeroDetailAPISevice.shared.loadJson(fromURLString: urlString) { (result) in
                switch result {
                case .success(let data):
                    let data = HeroDetailAPISevice.shared.parseAbility(heroNameOriginal: heroNameOriginal,
                                                                         jsonData: data)
                    guard let newdata = data else {
                        return
                    }
                    observer.onNext(newdata)
                case .failure(let error):
                    print(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func loadHeroAbilities() -> Observable<[HeroDetailAbilitiesModel]> {
        return Observable.create { observer -> Disposable in
            let urlString = ConstantsForJsonUrl.heroDetailAbilities
            
            HeroDetailAPISevice.shared.loadJson(fromURLString: urlString) { (result) in
                switch result {
                case .success(let data):
                    let data = HeroDetailAPISevice.shared.parseHeroAbilities(jsonData: data)
                    guard let newdata = data else {
                        return
                    }
                    observer.onNext(newdata)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            return Disposables.create()
        }
    }
    
    func loadHeroLore() -> Observable<[String: String]> {
        return Observable.create { (observer) -> Disposable in
            let urlString = ConstantsForJsonUrl.heroLores
            
            HeroDetailAPISevice.shared.loadJson(fromURLString: urlString) { (result) in
                switch result {
                case .success(let data):
                    let data = HeroDetailAPISevice.shared.parseLores(jsonData: data)
                    guard let newdata = data else {
                        return
                    }
                    observer.onNext(newdata)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            return Disposables.create()
        }
    }
    
    func changeLikeTitle(heroID: String) -> Observable<String> {
        let ref = Database.database().reference()
        
        return Observable.create { (observer) -> Disposable in
            if let user = Auth.auth().currentUser {
                ref.child("liked").child(user.uid).child(heroID).observe(.childAdded) { (_) in
                    observer.onNext("doStar")
                }
                ref.child("liked").child(user.uid).child(heroID).observe(.childRemoved) { (_) in
                   observer.onNext("unStar")
                }
            } else {
                observer.onNext("")
            }
            return Disposables.create()
        }
    }
    
    func like(heroID: String, data: HeroDetailViewModelPlus) {
        let ref = Database.database().reference()
        
        if let user = Auth.auth().currentUser {
            guard let name = data.name,
                let localizedName = data.localizedName
                else { return }
            
            guard let key = ref.child("liked").childByAutoId().key else { return }
            
            let value: [String: Any] = [
                "name": name,
                "localizedName": localizedName,
                "id": heroID,
                "timestamp": key
            ]
            
            let heroRef = ref.child("liked").child(user.uid)
            
            heroRef.getData(completion: { error, snapshot in
                guard error == nil else {
                    print("error like")
                    return
                }
                
                if snapshot.hasChild(heroID) == true {
                    ref.child("liked").child(user.uid).child(heroID).removeValue()
                } else {
                    ref.child("liked").child(user.uid).child(heroID).setValue(value)
                }
            })
        }
    }
}
