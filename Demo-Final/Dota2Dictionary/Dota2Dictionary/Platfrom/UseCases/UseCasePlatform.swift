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
    
    func loadFirstAllData() -> Observable<[HeroModel]> {
        return Observable.create { observer -> Disposable in
            Network.shared.getHeroAll { data, _ in
                if let data = data {
                    observer.onNext(data)
                }
            }
            return Disposables.create()
        }
    }
    
    func loadStrengthData() -> Observable<[HeroModel]> {
        return Observable.create { observer -> Disposable in
            Network.shared.getHeroAll { data, _ in
                if let data = data {
                    let newData = data.filter { $0.primaryAttr == "str" }
                    observer.onNext(newData)
                }
            }
            return Disposables.create()
        }
    }
    
    func loadAgibilityData() -> Observable<[HeroModel]> {
        return Observable.create { observer -> Disposable in
            Network.shared.getHeroAll {  data, _ in
                if let data = data {
                    let newData = data.filter { $0.primaryAttr == "agi" }
                    observer.onNext(newData)
                }
            }
            return Disposables.create()
        }
    }
    
    func loadIntelligentData() -> Observable<[HeroModel]> {
        return Observable.create { observer -> Disposable in
            Network.shared.getHeroAll {  data, _ in
                if let data = data {
                    let newData = data.filter { $0.primaryAttr == "int" }
                    observer.onNext(newData)
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
            let urlString = Constants.urlForHeroDetailJson
            let bag = DisposeBag()
            
            HeroDetailAPISevice.shared.loadJson(fromURLString: urlString) { (result) in
                switch result {
                case .success(let data):
                    let newdata = HeroDetailAPISevice.shared.parse(heroID: heroID, jsonData: data)
                    newdata
                        .subscribe { element in
                            observer.onNext(element)
                        }
                        .disposed(by: bag)
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
            let urlString = Constants.urlJsonForItemViewModel
            let bag = DisposeBag()
            
            ItemAPIService.shared.loadJson(fromURLString: urlString) { (result) in
                switch result {
                case .success(let data):
                    let data = ItemAPIService.shared.parse(jsonData: data)
                    data
                        .subscribe { element in
                            observer.onNext(element)
                        }
                        .disposed(by: bag)
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
            let urlString = Constants.urlJsonForItemDetailViewModel
            let bag = DisposeBag()
            
            ItemDetailAPIService.shared.loadJson(fromURLString: urlString) { (result) in
                switch result {
                case .success(let data):
                    let newdata = ItemDetailAPIService.shared.parse(itemKey: itemKey, jsonData: data)
                    newdata
                        .subscribe { element in
                            observer.onNext(element)
                        }
                        .disposed(by: bag)
                case .failure(let error):
                    print(error)
                }
            }
            return Disposables.create()
        }
    }
}
