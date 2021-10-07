//
//  PatchDetailViewModel.swift
//  Dota2Dictionary
//
//  Created by MacOS on 06/10/2021.
//

import Foundation
import RxSwift
import RxCocoa

class PatchDetailViewModel {
    let disposeBag = DisposeBag()

    var patchName: String
    
    var listDetails = BehaviorRelay<[PatchModel]>(value: [])
    var listDetailsNew = Observable<[NewPatchDetailViewModel]>.from([])
    
    init(patchName: String) {
        self.patchName = patchName
        self.bindingData()
    }
    
    func bindingData() {
        Network.shared.getDetailsAll(patchName: String(patchName)) { [weak self] data, _ in
            if let data = data {
                self?.listDetails.accept(data)
            }
        }
        listDetailsNew = listDetails.map {
            $0.map {
                NewPatchDetailViewModel(with: $0)
            }
        }
    }
}
