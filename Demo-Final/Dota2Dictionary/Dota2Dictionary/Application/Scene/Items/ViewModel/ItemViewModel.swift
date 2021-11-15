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
        
        let firstLoadingOutput = input
            .firstLoading
            .asObservable()
            .flatMapLatest {
                self
                    .useCase
                    .loadItemDataAtFirst()
            }
        
        let searchOutput = input
            .searchTrigger
            .asObservable()
            .debounce(RxTimeInterval.milliseconds(300),
                      scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map {
                $0.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            }
            .withLatestFrom(firstLoadingOutput) { searchText, items -> [String] in
                if searchText.isEmpty {
                    return items
                } else {
                   return items.filter { item in
                        item.lowercased().contains(searchText)
                    }
                }
            }
        
        let fetchOutput = Observable.of(firstLoadingOutput, searchOutput).merge()
        
        let selectedItem = input
            .selection
            .withLatestFrom(fetchOutput.asDriver(onErrorDriveWith: .empty())) { (indexPath, first) -> String in
                return first[indexPath.row]
            }
            .do(onNext: navigator.toItemDetail)
        
        return Output(selectedItem: selectedItem,
                      searchOutput: fetchOutput)
    }
}

// MARK: - Input Output
extension ItemViewModel {
    struct Input {
        let selection: Driver<IndexPath>
        let searchTrigger: Driver<String>
        let firstLoading: Driver<Void>
    }
    
    struct Output {
        let selectedItem: Driver<String>
        let searchOutput: Observable<[String]>
    }
    
}
