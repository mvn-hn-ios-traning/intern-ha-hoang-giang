//
//  HeroViewModel.swift
//  Dota2Dictionary
//
//  Created by MacOS on 27/09/2021.
//

import Foundation
import RxCocoa
import RxSwift

class HeroViewModel: ViewModelType {
    
    private let useCase: HeroUseCaseDomain
    
    init() {
        self.useCase = HeroUseCasePlatform()
    }
    
    func transform(input: Input) -> Output {
        let strength = input
            .strengthSelecting
            .asObservable()
            .flatMapLatest {
                return self
                    .useCase
                    .loadStrengthData()
            }.map { $0.map { HeroItemViewModel(with: $0) }
            }.asDriver(onErrorDriveWith: .empty())
        
        let agibility = input
            .agibilitySelecting
            .asObservable()
            .flatMapLatest {
                return self
                    .useCase
                    .loadAgibilityData()
            }.map { $0.map { HeroItemViewModel(with: $0) }
            }.asDriver(onErrorDriveWith: .empty())
        
        let intelligent = input
            .intelligentSelecting
            .asObservable()
            .flatMapLatest {
                return self
                    .useCase
                    .loadIntelligentData()
            }.map { $0.map { HeroItemViewModel(with: $0) }
            }.asDriver(onErrorDriveWith: .empty())
        
        let firstLoadingOutput = input
            .firstLoading
            .asObservable()
            .flatMapLatest {
                return self
                    .useCase
                    .loadStrengthData()
            }.map { $0.map { HeroItemViewModel(with: $0) }
            }.asDriver(onErrorDriveWith: .empty())
        
        let fetchOutput =
            Observable
            .of(strength.asObservable(),
                agibility.asObservable(),
                intelligent.asObservable(),
                firstLoadingOutput.asObservable())
            .merge()
        return Output(fetchOutput: fetchOutput)
    }
}

extension HeroViewModel {
    struct Input {
        let strengthSelecting: Driver<Void>
        let agibilitySelecting: Driver<Void>
        let intelligentSelecting: Driver<Void>
        let firstLoading: Driver<Void>
    }
    
    struct Output {
        let fetchOutput: Observable<[HeroItemViewModel]>
    }
}
