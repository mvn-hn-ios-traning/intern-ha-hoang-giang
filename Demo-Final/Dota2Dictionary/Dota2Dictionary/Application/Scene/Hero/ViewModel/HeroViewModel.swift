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
        let firstLoadingOutput = input
            .firstLoading
            .asObservable()
            .flatMap {
                return self
                    .useCase
                    .loadDataAtFirst()
            }
        
        let strength = input
            .selectStrength
            .asObservable()
            .flatMap {
                return self
                    .useCase
                    .loadDataAtFirst()
            }.map { $0.filter { $0.primaryAttr == "str" } }
        
        let agibility = input
            .selectAbility
            .asObservable()
            .flatMap {
                return self
                    .useCase
                    .loadDataAtFirst()
            }.map { $0.filter { $0.primaryAttr == "agi" } }
        
        let intelligent = input
            .selectIntelligent
            .asObservable()
            .flatMap {
                return self
                    .useCase
                    .loadDataAtFirst()
            }.map { $0.filter { $0.primaryAttr == "int" } }
        
        let fetchOutput = Observable
            .of(strength,
                agibility,
                intelligent,
                firstLoadingOutput)
            .merge()
            .map { $0.map { HeroViewModelPlus(with: $0) } }
            .asDriver(onErrorDriveWith: .empty())
        
        let selectedOutput = input
            .selection
            .withLatestFrom(fetchOutput) { (indexPath, first) -> HeroViewModelPlus in
                return first[indexPath.row]
            }
            .do(onNext: navigator.toHeroDetail)
        
        return Output(fetchOutput: fetchOutput,
                      selectedOutput: selectedOutput)
    }
}

extension HeroViewModel {
    struct Input {
        let selectStrength: Driver<Void>
        let selectAbility: Driver<Void>
        let selectIntelligent: Driver<Void>
        let firstLoading: Driver<Void>
        let selection: Driver<IndexPath>
    }
    
    struct Output {
        let fetchOutput: Driver<[HeroViewModelPlus]>
        let selectedOutput: Driver<HeroViewModelPlus>
    }
}
