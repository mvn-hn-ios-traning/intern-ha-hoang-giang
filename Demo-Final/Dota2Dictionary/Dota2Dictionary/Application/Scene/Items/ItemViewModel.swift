//
//  ItemViewModel.swift
//  Dota2Dictionary
//
//  Created by MacOS on 10/10/2021.
//

import Foundation
import RxSwift
import RxCocoa

class ItemViewModel {
    let disposeBag = DisposeBag()

    let urlString = "https://raw.githubusercontent.com/odota/dotaconstants/master/build/item_ids.json"

    var listArrayItem = Observable<[String]>.just([])
    
    init() {
        bindingData()
    }
    
    func bindingData() {
        ItemAPIService.shared.loadJson(fromURLString: urlString) { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.listArrayItem = ItemAPIService.shared.parse(jsonData: data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
