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
        
        let fetchBtnOut = input
            .fetchBtn
            .map { element -> Observable<[HeroModel]> in
                switch element {
                case .str:
                    return input
                        .fetchBtn
                        .withLatestFrom(firstLoadingOutput) { button, heroes in
                            heroes.filter { $0.primaryAttr == button.rawValue }
                        }
                case .agi:
                    return input
                        .fetchBtn
                        .withLatestFrom(firstLoadingOutput) { button, heroes in
                            heroes.filter { $0.primaryAttr == button.rawValue }
                        }
                case .int:
                    return input
                        .fetchBtn
                        .withLatestFrom(firstLoadingOutput) { button, heroes in
                            heroes.filter { $0.primaryAttr == button.rawValue }
                        }
                }
            }
            .flatMap { $0 }
        
        let fetchOutput = Observable
            .of(fetchBtnOut,
                firstLoadingOutput)
            .merge()
            .map { $0.map { HeroViewModelPlus(with: $0) } }
            .asDriver(onErrorDriveWith: .empty())
        
        let selectedOutput = input
            .selection
            .withLatestFrom(fetchOutput) { (indexPath, first) -> HeroViewModelPlus in
                return first[indexPath.row]
            }
            .do(onNext: navigator.toHeroDetail(_:))
        
        return Output(fetchOutput: fetchOutput,
                      selectedOutput: selectedOutput)
    }
}

// MARK: Input Output
extension HeroViewModel {
    struct Input {
        let firstLoading: Driver<Void>
        let selection: Driver<IndexPath>
        let fetchBtn: Observable<HeroAttributeButton>
    }
    
    struct Output {
        let fetchOutput: Driver<[HeroViewModelPlus]>
        let selectedOutput: Driver<HeroViewModelPlus>
    }
}
