//
//  ItemDetailUseCasePlatform.swift
//  Dota2Dictionary
//
//  Created by MacOS on 10/11/2021.
//

import Foundation
import RxSwift

// MARK: - Item Detail
class ItemDetailUseCasePlatform: ItemDetailUseCaseDomain {
    func loadItemDetailDataAtFirst(itemKey: String) -> Observable<ItemDetailModel> {
        return Observable.create { observer -> Disposable in
            let urlString = ConstantsForJsonUrl.itemDetailViewModelLink
            
            ItemDetailAPIService.shared.loadJson(fromURLString: urlString) { (result) in
                switch result {
                case .success(let data):
                    let data = ItemDetailAPIService.shared.parse(itemKey: itemKey, jsonData: data)
                    guard let newData = data else {
                        return
                    }
                    observer.onNext(newData)
                case .failure(let error):
                    print(error)
                }
            }
            return Disposables.create()
        }
    }
}
