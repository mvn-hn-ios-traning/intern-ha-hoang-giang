//
//  ItemUseCasePlatform.swift
//  Dota2Dictionary
//
//  Created by MacOS on 10/11/2021.
//

import Foundation
import RxSwift

// MARK: - Item
class ItemUseCasePlatform: ItemUseCaseDomain {
    func loadItemDataAtFirst() -> Observable<[String]> {
        return Observable.create { observer -> Disposable in
            let urlString = ConstantsForJsonUrl.itemViewModelLink
            
            ItemAPIService.shared.loadJson(fromURLString: urlString) { (result) in
                switch result {
                case .success(let data):
                    let data = ItemAPIService.shared.parse(jsonData: data)
                    guard let newData = data else { return }
                    observer.onNext(newData)
                case .failure(let error):
                    print(error)
                }
            }
            return Disposables.create()
        }
    }
}
