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
    let disposeBag = DisposeBag()
    
    private let useCase: PatchUseCaseDomain
    private let navigator: PatchNavigator
    
//    var listPatch = BehaviorRelay<[PatchModel]>(value: [])
//    var listPatchNew = Observable<[NewPatchDetailViewModel]>.from([])
    
    init(useCase: PatchUseCaseDomain,
         navigator: PatchNavigator) {
        self.useCase = useCase
        self.navigator = navigator
//        bindingData()
    }
    
//    func bindingData() {
//        Network.shared.getPatchAll { [weak self] data, _ in
//            if let data = data {
//                self?.listPatch.accept(data)
//            }
//        }
//        listPatchNew = listPatch.map {
//            $0.map {
//                NewPatchDetailViewModel(with: $0)
//            }
//        }
//    }
    
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
            }.do(onNext: navigator.toPatchDetail)
        
        return Output(firstLoadingOutput: firstLoadingOutput,
                      selectedOutput: selectedOutput)
    }
}

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
