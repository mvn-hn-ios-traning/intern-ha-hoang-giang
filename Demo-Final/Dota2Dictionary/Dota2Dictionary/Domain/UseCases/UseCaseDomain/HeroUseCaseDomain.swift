//
//  HeroUseCaseDomain.swift
//  Dota2Dictionary
//
//  Created by MacOS on 10/11/2021.
//

import Foundation
import RxSwift

// MARK: - Hero
public protocol HeroUseCaseDomain {
    func loadDataAtFirst() -> Observable<[HeroModel]>
}
