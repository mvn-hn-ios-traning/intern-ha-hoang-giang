//
//  PatchViewModel.swift
//  Dota2Dictionary
//
//  Created by MacOS on 22/09/2021.
//

import Foundation
import RxCocoa
import RxSwift

class PatchViewModel {
    let disposeBag = DisposeBag()
    
    var listPatch = BehaviorRelay<[PatchModel]>(value: [])
    var listPatchNew = Observable<[NewPatchDetailViewModel]>.from([])
    
    init() {
        bindingData()
    }
    
    func bindingData() {
        Network.shared.getPatchAll { [weak self] data, _ in
            if let data = data {
                self?.listPatch.accept(data)
            }
        }
        listPatchNew = listPatch.map {
            $0.map {
                NewPatchDetailViewModel(with: $0)
            }
        }
    }
}
