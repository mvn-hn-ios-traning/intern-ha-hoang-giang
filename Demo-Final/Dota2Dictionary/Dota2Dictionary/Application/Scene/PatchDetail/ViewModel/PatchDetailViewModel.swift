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
            }.map({
                $0.map { NewPatchDetailViewModel(with: $0) }
            })
            .asDriver(onErrorDriveWith: .empty())
        
        let heroesPatch = input
            .heroesPatchSelecting
            .asObservable()
            .flatMapLatest {
                return self
                    .useCase
                    .loadHeroesPatchData(patchVersion: self.patchName)
            }.map({
                $0.map { NewPatchDetailViewModel(with: $0) }
            })
            .asDriver(onErrorDriveWith: .empty())
        
        let itemsPatch = input
            .itemsPatchSelecting
            .asObservable()
            .flatMapLatest {
                return self
                    .useCase
                    .loadItemsPatchData(patchVersion: self.patchName)
            }.map({
                $0.map { NewPatchDetailViewModel(with: $0) }
            })
            .asDriver(onErrorDriveWith: .empty())
        
        let fetch = Observable
            .of(firstLoadingOutput.asObservable(),
                heroesPatch.asObservable(),
                itemsPatch.asObservable())
            .merge()
        
        return Output(fetchOutput: fetch)
    }
    
}

extension PatchDetailViewModel {
    struct Input {
        let heroesPatchSelecting: Driver<Void>
        let itemsPatchSelecting: Driver<Void>
        let firstLoading: Driver<Void>
    }
    
    struct Output {
        let fetchOutput: Observable<[NewPatchDetailViewModel]>
    }
}
