//
//  ItemUseCaseDomain.swift
//  Dota2Dictionary
//
//  Created by MacOS on 10/11/2021.
//

import Foundation
import RxSwift

// MARK: - Item
public protocol ItemUseCaseDomain {
    func loadItemDataAtFirst() -> Observable<[String]>
}
