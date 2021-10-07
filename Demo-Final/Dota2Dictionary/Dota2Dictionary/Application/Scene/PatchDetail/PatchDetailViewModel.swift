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
    
    let disposeBag = DisposeBag()

    var patchName: String
    
    var listDetails = BehaviorRelay<[PatchModel]>(value: [])
    var listDetailsNew = Observable<[NewPatchDetailViewModel]>.from([])
    
    private let useCase: PatchDetailUseCasePlatform

    init(patchName: String) {
        self.patchName = patchName
        self.useCase = PatchDetailUseCasePlatform()
    }
    
    func transform(input: Input) -> Output {
        let trigger = input
            .trigger
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
            .of(trigger.asObservable(),
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
        let trigger: Driver<Void>
    }
    
    struct Output {
        let fetchOutput: Observable<[NewPatchDetailViewModel]>
    }
}
