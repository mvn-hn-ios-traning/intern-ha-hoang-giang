//
//  PatchDetailUseCasePlatform.swift
//  Dota2Dictionary
//
//  Created by MacOS on 10/11/2021.
//

import Foundation
import RxSwift

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
