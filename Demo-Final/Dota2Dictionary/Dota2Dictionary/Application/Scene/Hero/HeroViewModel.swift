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
    private let navigator: DefaultHeroNavigator
    
    init(useCase: HeroUseCaseDomain, navigator: DefaultHeroNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        let strength = input
            .strengthSelecting
            .asObservable()
            .flatMapLatest {
                return self
                    .useCase
                    .loadStrengthData()
            }.map { $0.map { HeroViewModelPlus(with: $0) }
            }.asDriver(onErrorDriveWith: .empty())
        
        let agibility = input
            .agibilitySelecting
            .asObservable()
            .flatMapLatest {
                return self
                    .useCase
                    .loadAgibilityData()
            }.map { $0.map { HeroViewModelPlus(with: $0) }
            }.asDriver(onErrorDriveWith: .empty())
        
        let intelligent = input
            .intelligentSelecting
            .asObservable()
            .flatMapLatest {
                return self
                    .useCase
                    .loadIntelligentData()
            }.map { $0.map { HeroViewModelPlus(with: $0) }
            }.asDriver(onErrorDriveWith: .empty())
        
        let firstLoadingOutput = input
            .firstLoading
            .asObservable()
            .flatMapLatest {
                return self
                    .useCase
                    .loadFirstAllData()
            }.map { $0.map { HeroViewModelPlus(with: $0) }
            }.asDriver(onErrorDriveWith: .empty())
        
        let fetchOutput =
            Observable
            .of(strength.asObservable(),
                agibility.asObservable(),
                intelligent.asObservable(),
                firstLoadingOutput.asObservable())
            .merge()
        
        let selectedOutput = input
            .selection
            .withLatestFrom(firstLoadingOutput) { (indexPath, first) -> HeroViewModelPlus in
                return first[indexPath.row]
            }
            .do(onNext: navigator.toHeroDetail)
        
        return Output(fetchOutput: fetchOutput,
                      selectedOutput: selectedOutput)
    }
}

extension HeroViewModel {
    struct Input {
        let strengthSelecting: Driver<Void>
        let agibilitySelecting: Driver<Void>
        let intelligentSelecting: Driver<Void>
        let firstLoading: Driver<Void>
        let selection: Driver<IndexPath>
    }
    
    struct Output {
        let fetchOutput: Observable<[HeroViewModelPlus]>
        let selectedOutput: Driver<HeroViewModelPlus>
    }
}
