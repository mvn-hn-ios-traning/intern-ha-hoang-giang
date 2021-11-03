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
            }
        
        let searchOutput = input
            .searchTrigger
            .asObservable()
            .throttle(.milliseconds(300),
                      scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map { query in
                firstLoadingOutput
                    .map {
                        $0.filter { item in
                            query.isEmpty || item.lowercased().contains(query.lowercased())
                        }
                    }
            }
            .flatMap { $0 }
        
        let selectedItem = input
            .selection
            .withLatestFrom(searchOutput.asDriver(onErrorDriveWith: .empty())) { (indexPath, first) -> String in
                return first[indexPath.row]
            }
            .do(onNext: navigator.toItemDetail)
            
        return Output(firstLoadingOutput: firstLoadingOutput,
                      selectedItem: selectedItem,
                      searchOutput: searchOutput)
    }
}

extension ItemViewModel {
    struct Input {
        let firstLoading: Driver<Void>
        let selection: Driver<IndexPath>
        let searchTrigger: Driver<String>
    }
    
    struct Output {
        let firstLoadingOutput: Observable<[String]>
        let selectedItem: Driver<String>
        let searchOutput: Observable<[String]>
    }
    
}
