//
//  UseCasePlatform.swift
//  Dota2Dictionary
//
//  Created by MacOS on 22/09/2021.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - Patch
class PatchUseCasePlatform: PatchUseCaseDomain {
    func loadPatchDataAllFirst() -> Observable<[PatchModel]> {
        return Observable.create { (observer) -> Disposable in
            Network.shared.getPatchAll { data, _ in
                if let data = data {
                    observer.onNext(data)
                }
            }
            return Disposables.create()
        }
    }
}

// MARK: - PatchDetail
class PatchDetailUseCasePlatform: PatchDetailUseCaseDomain {
    func loadHeroesPatchData(patchVersion: String) -> Observable<[PatchModel]> {
        return Observable.create { observer -> Disposable in
            Network.shared.getHeroesDetailAll(patchName: patchVersion) {  data, _ in
                if let data = data {
                    observer.onNext(data)
                }
            }
            return Disposables.create()
        }
    }
    
    func loadItemsPatchData(patchVersion: String) -> Observable<[PatchModel]> {
        return Observable.create { observer -> Disposable in
            Network.shared.getItemsDetailAll(patchName: patchVersion) {  data, _ in
                if let data = data {
                    observer.onNext(data)
                }
            }
            return Disposables.create()
        }
    }
}

// MARK: - Hero
class HeroUseCasePlatform: HeroUseCaseDomain {
    func loadDataAtFirst() -> Observable<[HeroModel]> {
        return Observable.create { observer -> Disposable in
            Network.shared.getHeroAll { data, _ in
                if let data = data {
                    observer.onNext(data)
                }
            }
            return Disposables.create()
        }
    }
}

// MARK: Hero Detail
class HeroDetailUseCasePlatform: HeroDetailUseCaseDomain {
    
    func loadHeroDetailDataAtFirst(heroID: String) -> Observable<HeroDetailModel> {
        return Observable.create { observer -> Disposable in
            let urlString = ConstantsForJsonUrl.heroDetailAllInfo
            
            HeroDetailAPISevice.shared.loadJson(fromURLString: urlString) { (result) in
                switch result {
                case .success(let data):
                    let data = HeroDetailAPISevice.shared.parse(heroID: heroID, jsonData: data)
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
    
    func loadHeroDetailRoles() -> Observable<[RolesDetail]> {
        return Observable.create { observer -> Disposable in
            let urlString = ConstantsForJsonUrl.heroDetailRole
            
            HeroDetailAPISevice.shared.loadJson(fromURLString: urlString) { (result) in
                switch result {
                case .success(let data):
                    let data = HeroDetailAPISevice.shared.parseRoles(jsonData: data)
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

// MARK: - Item
class ItemUseCasePlatform: ItemUseCaseDomain {
    func loadItemDataAtFirst() -> Observable<[String]> {
        return Observable.create { observer -> Disposable in
            let urlString = ConstantsForJsonUrl.itemViewModelLink
            
            ItemAPIService.shared.loadJson(fromURLString: urlString) { (result) in
                switch result {
                case .success(let data):
                    let data = ItemAPIService.shared.parse(jsonData: data)
                    observer.onNext(data)
                case .failure(let error):
                    print(error)
                }
            }
            return Disposables.create()
        }
    }
}

// MARK: - Item Detail
class ItemDetailUseCasePlatform: ItemDetailUseCaseDomain {
    func loadItemDetailDataAtFirst(itemKey: String) -> Observable<ItemDetailModel> {
        return Observable.create { observer -> Disposable in
            let urlString = ConstantsForJsonUrl.itemDetailViewModelLink
            
            ItemDetailAPIService.shared.loadJson(fromURLString: urlString) { (result) in
                switch result {
                case .success(let data):
                    let newdata = ItemDetailAPIService.shared.parse(itemKey: itemKey, jsonData: data)
                    guard let newdata2 = newdata else { return }
                    observer.onNext(newdata2)
                case .failure(let error):
                    print(error)
                }
            }
            return Disposables.create()
        }
    }
}
