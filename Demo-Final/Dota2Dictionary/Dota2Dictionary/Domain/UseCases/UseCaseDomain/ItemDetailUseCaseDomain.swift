//
//  ItemDetailUseCaseDomain.swift
//  Dota2Dictionary
//
//  Created by MacOS on 10/11/2021.
//

import Foundation
import RxSwift

// MARK: - Item Detail
public protocol ItemDetailUseCaseDomain {
    func loadItemDetailDataAtFirst(itemKey: String) -> Observable<ItemDetailModel>
}
