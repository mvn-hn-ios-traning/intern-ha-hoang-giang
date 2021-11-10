//
//  PatchDetailViewModel.swift
//  Dota2Dictionary
//
//  Created by MacOS on 06/10/2021.
//

import Foundation
import RxSwift
import RxCocoa

class PatchDetailViewModel: ViewModelType {
    
    var patchName: String
    
    private let useCase: PatchDetailUseCasePlatform

    init(patchName: String) {
        self.patchName = patchName
        self.useCase = PatchDetailUseCasePlatform()
    }
    
    func transform(input: Input) -> Output {
        let firstLoadingOutput = input
            .firstLoading
            .asObservable()
            .flatMapLatest {
                return self
                    .useCase
                    .loadHeroesPatchData(patchVersion: self.patchName)
            }
        
        let heroesPatch = input
            .selectHeroPatch
            .asObservable()
            .flatMapLatest {
                return self
                    .useCase
                    .loadHeroesPatchData(patchVersion: self.patchName)
            }
        
        let itemsPatch = input
            .selectItemPatch
            .asObservable()
            .flatMapLatest {
                return self
                    .useCase
                    .loadItemsPatchData(patchVersion: self.patchName)
            }
        
        let fetch = Observable
            .of(firstLoadingOutput,
                heroesPatch,
                itemsPatch)
            .merge()
            .map({
                $0.map { NewPatchDetailViewModel(with: $0) }
            })
        
        return Output(fetchOutput: fetch)
    }
    
}

extension PatchDetailViewModel {
    struct Input {
        let selectHeroPatch: Driver<Void>
        let selectItemPatch: Driver<Void>
        let firstLoading: Driver<Void>
    }
    
    struct Output {
        let fetchOutput: Observable<[NewPatchDetailViewModel]>
    }
}
