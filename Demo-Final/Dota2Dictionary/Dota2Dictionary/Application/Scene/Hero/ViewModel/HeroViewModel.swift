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
    
    init(useCase: HeroUseCaseDomain,
         navigator: DefaultHeroNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    // MARK: - Transform
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
                .strengthSelecting
                .asObservable()
                .flatMap {
                    return self
                        .useCase
                        .loadDataAtFirst()
                }.map { $0.filter { $0.primaryAttr == "str" } }
            
            let agibility = input
                .agibilitySelecting
                .asObservable()
                .flatMap {
                    return self
                        .useCase
                        .loadDataAtFirst()
                }.map { $0.filter { $0.primaryAttr == "agi" } }
            
            let intelligent = input
                .intelligentSelecting
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

// MARK: Input Output
extension HeroViewModel {
    struct Input {
        let strengthSelecting: Driver<Void>
        let agibilitySelecting: Driver<Void>
        let intelligentSelecting: Driver<Void>
        let firstLoading: Driver<Void>
        let selection: Driver<IndexPath>
    }
    
    struct Output {
        let fetchOutput: Driver<[HeroViewModelPlus]>
        let selectedOutput: Driver<HeroViewModelPlus>
    }
}
