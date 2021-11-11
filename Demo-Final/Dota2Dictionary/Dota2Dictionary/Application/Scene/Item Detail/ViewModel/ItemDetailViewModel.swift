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
        let allDataOutput = input
            .loadAllDataAfterFilter
            .asObservable()
            .flatMapLatest {
                return self
                    .useCase
                    .loadItemDetailDataAtFirst(itemKey: self.itemKey)
            }.map {
                ItemDetailViewModelPlus(with: $0)
            }.asDriver(onErrorDriveWith: .empty())
            
        let dataForCell = allDataOutput
            .asObservable()
            .map {
                [ItemDetailTableViewSection](arrayLiteral:
                                                .infoSection(items: [.itemInfoTopItem(info: $0)]),
                                             .hintSection(items: [.itemHintItem(hint: $0)]),
                                             .manacdSection(items: [.itemManaColdownItem(manacd: $0)]),
                                             .notesSection(items: [.itemNotesItem(notes: $0)]),
                                             .attribSection(items: [.itemAttribItem(attrib: $0)]),
                                             .loreSection(items: [.itemLoreItem(lore: $0)]),
                                             .componentsSection(items: [.itemComponentsItem(components: $0)])
                )
            }
        
        return Output(allDataOutput: allDataOutput,
                      dataForCell: dataForCell)
    }
    
}

// MARK - Input Output
extension ItemDetailViewModel {
    struct Input {
        let loadAllDataAfterFilter: Driver<Void>
    }
    
    struct Output {
        let allDataOutput: Driver<ItemDetailViewModelPlus>
        let dataForCell: Observable<[ItemDetailTableViewSection]>
    }
}
