//
//  PatchViewModel.swift
//  Dota2Dictionary
//
//  Created by MacOS on 22/09/2021.
//

import Foundation
import RxCocoa
import RxSwift

class PatchViewModel: ViewModelType {
    
    private let useCase: PatchUseCaseDomain
    private let navigator: DefaultPatchNavigator
    
    init(useCase: PatchUseCaseDomain,
         navigator: DefaultPatchNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    // MARK: Transform
    func transform(input: Input) -> Output {
        let firstLoadingOutput = input
            .firstLoading
            .asObservable()
            .flatMapLatest {
                return self
                    .useCase
                    .loadPatchDataAllFirst()
            }.map {
                $0.map { NewPatchDetailViewModel(with: $0) }
            }.asDriver(onErrorDriveWith: .empty())
        
        let selectedOutput = input
            .selection
            .withLatestFrom(firstLoadingOutput) { (indexPath, first) -> NewPatchDetailViewModel in
                return first[indexPath.row]
            }
            .do(onNext: navigator.toPatchDetail)
        
        return Output(firstLoadingOutput: firstLoadingOutput,
                      selectedOutput: selectedOutput)
    }
}

// MARK: - Input Output
extension PatchViewModel {
    struct Input {
        let firstLoading: Driver<Void>
        let selection: Driver<IndexPath>
    }
    
    struct Output {
        let firstLoadingOutput: Driver<[NewPatchDetailViewModel]>
        let selectedOutput: Driver<NewPatchDetailViewModel>
    }
}
