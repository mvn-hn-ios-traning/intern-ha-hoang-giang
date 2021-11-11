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
    
    // MARK: - Transform
    func transform(input: Input) -> Output {
        
        let searchOutput = input
            .searchTrigger
            .asObservable()
            .throttle(RxTimeInterval.milliseconds(300),
                      scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { query in
                self
                    .useCase
                    .loadItemDataAtFirst()
                    .map {
                        $0.filter { item in
                            query.isEmpty || item.lowercased().contains(query.lowercased())
                        }
                    }
            }
        
        let selectedItem = input
            .selection
            .withLatestFrom(searchOutput.asDriver(onErrorDriveWith: .empty())) { (indexPath, first) -> String in
                return first[indexPath.row]
            }
            .do(onNext: navigator.toItemDetail)
        
        return Output(selectedItem: selectedItem,
                      searchOutput: searchOutput)
    }
}

// MARK: - Input Output
extension ItemViewModel {
    struct Input {
        let selection: Driver<IndexPath>
        let searchTrigger: Driver<String>
    }
    
    struct Output {
        let selectedItem: Driver<String>
        let searchOutput: Observable<[String]>
    }
    
}
