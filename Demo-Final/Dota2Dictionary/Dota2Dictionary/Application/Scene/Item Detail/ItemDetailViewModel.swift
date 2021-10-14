//
//  ItemDetailViewModel.swift
//  Dota2Dictionary
//
//  Created by MacOS on 12/10/2021.
//

import Foundation
import RxCocoa
import RxSwift

class ItemDetailViewModel {
    
    var itemKey = ""
    
    private let useCase: ItemDetailUseCaseDomain
    
    init(itemKey: String,
         useCase: ItemDetailUseCaseDomain) {
        self.itemKey = itemKey
        self.useCase = useCase
    }
    
//    func transform(input: Input) -> Output {
//          
//
//        return
//    }
    
}

extension ItemDetailViewModel {
    struct Input {
        
    }
    
    struct Output {
        let fetchOutput: Driver<ItemDetailViewModelPlus>
    }
}
