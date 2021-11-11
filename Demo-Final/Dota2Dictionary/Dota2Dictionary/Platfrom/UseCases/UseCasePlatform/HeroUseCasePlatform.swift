//
//  HeroUseCasePlatform.swift
//  Dota2Dictionary
//
//  Created by MacOS on 10/11/2021.
//

import Foundation
import RxSwift

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
