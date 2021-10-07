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
    
    let disposeBag = DisposeBag()
    
    var listHero = BehaviorRelay<[HeroModel]>(value: [])
    var listHeroNew = Observable<[HeroItemViewModel]>.from([])
    
    private let useCase: HeroUseCasePlatform
    
    init() {
        self.useCase = HeroUseCasePlatform()
        bindingData()
    }
    
    func bindingData() {
        Network.shared.getHeroAll { [weak self] data, _ in
            if let data = data {
                self?.listHero.accept(data)
            }
        }
        listHeroNew = listHero.map {
            $0.map {
                HeroItemViewModel(with: $0)
            }
        }
    }
    
    func transform(input: Input) -> Output {
        let strength = input
            .strengthSelecting
            .asObservable()
            .flatMapLatest {
                return self
                    .useCase
                    .loadStrengthData()
            }
            .map {
                $0.filter {
                    $0.primaryAttr == "str"
                }
            }.map({
                $0.map { HeroItemViewModel(with: $0) }
            })
            .asDriver(onErrorDriveWith: .empty())
        
        let agibility = input
            .agibilitySelecting
            .asObservable()
            .flatMapLatest {
                return self
                    .useCase
                    .loadAgibilityData()
            }
            .map {
                $0.filter {
                    $0.primaryAttr == "agi"
                }
            }.map({
                $0.map { HeroItemViewModel(with: $0) }
            })
            .asDriver(onErrorDriveWith: .empty())
        
        let intelligent = input
            .intelligentSelecting
            .asObservable()
            .flatMapLatest {
                return self
                    .useCase
                    .loadIntelligentData()
            }
            .map {
                $0.filter {
                    $0.primaryAttr == "int"
                }
            }.map({
                $0.map { HeroItemViewModel(with: $0) }
            })
            .asDriver(onErrorDriveWith: .empty())
        
        let triggerOutput = input
            .trigger
            .asObservable()
            .flatMapLatest {
                return self
                    .useCase
                    .loadStrengthData()
            }.map({
                $0.map { HeroItemViewModel(with: $0) }
            })
            .asDriver(onErrorDriveWith: .empty())
        
        let fetchOutput = Observable.of(strength.asObservable(),
                                          agibility.asObservable(),
                                          intelligent.asObservable(),
                                          triggerOutput.asObservable()).merge()
        
        return Output(fetchOutput: fetchOutput)
    }
}

extension HeroViewModel {
    struct Input {
        let strengthSelecting: Driver<Void>
        let agibilitySelecting: Driver<Void>
        let intelligentSelecting: Driver<Void>
        let trigger: Driver<Void>
    }
    
    struct Output {
        let fetchOutput: Observable<[HeroItemViewModel]>
    }
}
