//
//  ItemViewModel.swift
//  Dota2Dictionary
//
//  Created by MacOS on 10/10/2021.
//

import Foundation
import RxSwift
import RxCocoa

class ItemViewModel: ViewModelType {
    
    private let useCase: ItemUseCaseDomain
    private let navigator: DefaultItemNavigator
    
    init(useCase: ItemUseCaseDomain, navigator: DefaultItemNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        let firstLoadingOutput = input
            .firstLoading
            .asObservable()
            .flatMapLatest {
                return self
                    .useCase
                    .loadItemDataAtFirst()
            }.asDriver(onErrorDriveWith: .empty())
        
        let selectedItem = input
            .selection
            .withLatestFrom(firstLoadingOutput) { (indexPath, first) -> String in
                return first[indexPath.row]
            }
            .do(onNext: navigator.toItemDetail)
        
        return Output(fetchOutput: firstLoadingOutput,
                      selectedItem: selectedItem)
    }
    
}

extension ItemViewModel {
    struct Input {
        let firstLoading: Driver<Void>
        let selection: Driver<IndexPath>
    }
    
    struct Output {
        let fetchOutput: Driver<[String]>
        let selectedItem: Driver<String>
    }
    
}
