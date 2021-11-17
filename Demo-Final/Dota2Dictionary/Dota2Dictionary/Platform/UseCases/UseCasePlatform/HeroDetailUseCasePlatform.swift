//
//  HeroDetailUseCasePlatform.swift
//  Dota2Dictionary
//
//  Created by MacOS on 10/11/2021.
//

import Foundation
import RxSwift

// MARK: Hero Detail
class HeroDetailUseCasePlatform: HeroDetailUseCaseDomain {
    func loadHeroDetailDataAtFirst(heroID: String) -> Observable<HeroDetailModel> {
        return Observable.create { observer -> Disposable in
            let urlString = ConstantsForJsonUrl.heroDetailAllInfo
            
            HeroDetailAPISevice.shared.loadJson(fromURLString: urlString) { (result) in
                switch result {
                case .success(let data):
                    let data = HeroDetailAPISevice.shared.parse(heroID: heroID, jsonData: data)
                    guard let newdata = data else { return }
                    observer.onNext(newdata)
                case .failure(let error):
                    print(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func loadHeroDetailRoles() -> Observable<[RolesDetail]> {
        return Observable.create { observer -> Disposable in
            let urlString = ConstantsForJsonUrl.heroDetailRole
            
            HeroDetailAPISevice.shared.loadJson(fromURLString: urlString) { (result) in
                switch result {
                case .success(let data):
                    let data = HeroDetailAPISevice.shared.parseRoles(jsonData: data)
                    guard let newdata = data else { return }
                    observer.onNext(newdata)
                case .failure(let error):
                    print(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func loadHeroAbilityId() -> Observable<[String: String]> {
        return Observable.create { observer -> Disposable in
            let urlString = ConstantsForJsonUrl.heroAbilitiesId
            
            HeroDetailAPISevice.shared.loadJson(fromURLString: urlString) { (result) in
                switch result {
                case .success(let data):
                    let data = HeroDetailAPISevice.shared.parseAbilityId(jsonData: data)
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
                    print(error)
                }
            }
            return Disposables.create()
        }
    }
}
