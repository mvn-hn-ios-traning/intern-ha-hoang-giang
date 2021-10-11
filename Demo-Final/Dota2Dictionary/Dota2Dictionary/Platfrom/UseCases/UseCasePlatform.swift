//
//  UseCasePlatform.swift
//  Dota2Dictionary
//
//  Created by MacOS on 22/09/2021.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - Hero
class HeroUseCasePlatform: HeroUseCaseDomain {
        
    func loadStrengthData() -> Observable<[HeroModel]> {
        return Observable.create { observer -> Disposable in
            Network.shared.getHeroAll { data, _ in
                if let data = data {
                    observer.onNext(data)
                }
            }
            return Disposables.create()
        }
    }
    
    func loadAgibilityData() -> Observable<[HeroModel]> {
        return Observable.create { observer -> Disposable in
            Network.shared.getHeroAll {  data, _ in
                if let data = data {
                    observer.onNext(data)
                }
            }
            return Disposables.create()
        }
    }
    
    func loadIntelligentData() -> Observable<[HeroModel]> {
        return Observable.create { observer -> Disposable in
            Network.shared.getHeroAll {  data, _ in
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

// MARK: Hero Detail
