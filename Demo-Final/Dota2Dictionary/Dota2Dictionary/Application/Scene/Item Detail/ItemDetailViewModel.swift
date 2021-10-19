//
//  ItemDetailViewModel.swift
//  Dota2Dictionary
//
//  Created by MacOS on 12/10/2021.
//

import Foundation
import RxCocoa
import RxSwift

class ItemDetailViewModel: ViewModelType {
    
    var itemKey: String
    
    private let useCase: ItemDetailUseCaseDomain
    
    init(itemKey: String,
         useCase: ItemDetailUseCaseDomain) {
        self.itemKey = itemKey
        self.useCase = useCase
    }
    
    func transform(input: Input) -> Output {
        let firstLoadingOutput = input
            .firstLoading
            .asObservable()
            .flatMapLatest {
            return self
                .useCase
                .loadItemDetailDataAtFirst(itemKey: self.itemKey)
        }.map { ItemDetailViewModelPlus(with: $0) }
        .asDriver(onErrorDriveWith: .empty())
        .asObservable()
        
        let avatarName = firstLoadingOutput
            .map { $0.imageLink }
            .asDriver(onErrorDriveWith: .empty())
        
        let nameOutput = firstLoadingOutput
            .map { $0.dname }
            .asDriver(onErrorDriveWith: .empty())
        
        let costOutput = firstLoadingOutput
            .map { String($0.cost) }
            .asDriver(onErrorDriveWith: .empty())
        
        let hintOutput = firstLoadingOutput
            .map { $0.newHint }
            .asDriver(onErrorDriveWith: .empty())
        
        let manaCostOutput = firstLoadingOutput
            .map { $0.newManaCost }
            .asDriver(onErrorDriveWith: .empty())
        
        let coldownOutput = firstLoadingOutput
            .map { $0.newColdown }
            .asDriver(onErrorDriveWith: .empty())
        
        let notesOutput = firstLoadingOutput
            .map { $0.notes }
            .asDriver(onErrorDriveWith: .empty())
        
        let attributeOutput = firstLoadingOutput
            .map { $0.newAttrib }
            .asDriver(onErrorDriveWith: .empty())
        
        let loreOutput = firstLoadingOutput
            .map { $0.lore }
            .asDriver(onErrorDriveWith: .empty())
        
        let componentOutput = firstLoadingOutput
            .map { $0.components }
            .asDriver(onErrorDriveWith: .empty())
        
        return Output(firstLoadingOutput: firstLoadingOutput,
                      avatarOutput: avatarName,
                      nameOutput: nameOutput,
                      costOutput: costOutput,
                      hintOutput: hintOutput,
                      manaCostOutput: manaCostOutput,
                      coldownOutput: coldownOutput,
                      notesOutput: notesOutput,
                      attributeOutput: attributeOutput,
                      loreOutput: loreOutput,
                      componentOutput: componentOutput)
    }
    
}

extension ItemDetailViewModel {
    struct Input {
        let firstLoading: Driver<Void>
        let avatarFirstLoading: Driver<String>
        let nameLoading: Driver<String>
        let costLoading: Driver<String>
        let hintLoading: Driver<String>
        let manaCostLoading: Driver<String>
        let coldownLoading: Driver<String>
        let notesLoading: Driver<String>
        let attributeLoading: Driver<String>
        let loreLoading: Driver<String>
        let componentLoading: Driver<[String]>
    }
    
    struct Output {
        let firstLoadingOutput: Observable<ItemDetailViewModelPlus>
        let avatarOutput: Driver<String>
        let nameOutput: Driver<String>
        let costOutput: Driver<String>
        let hintOutput: Driver<String>
        let manaCostOutput: Driver<String>
        let coldownOutput: Driver<String>
        let notesOutput: Driver<String>
        let attributeOutput: Driver<String>
        let loreOutput: Driver<String>
        let componentOutput: Driver<[String]>
    }
}
