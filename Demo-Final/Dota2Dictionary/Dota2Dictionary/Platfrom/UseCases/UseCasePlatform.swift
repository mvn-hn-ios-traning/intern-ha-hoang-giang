//
//  UseCasePlatform.swift
//  Dota2Dictionary
//
//  Created by MacOS on 22/09/2021.
//

import Foundation
import RxSwift
import RxCocoa

class HeroUseCasePlatform: HeroUseCaseDomain {
    let disposeBag = DisposeBag()
        
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
