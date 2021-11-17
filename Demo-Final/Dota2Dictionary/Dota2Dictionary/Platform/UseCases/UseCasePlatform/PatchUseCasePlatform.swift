//
//  UseCasePlatform.swift
//  Dota2Dictionary
//
//  Created by MacOS on 22/09/2021.
//

import Foundation
import RxSwift

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
