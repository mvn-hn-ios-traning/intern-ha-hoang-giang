//
//  UseCaseDomain.swift
//  Dota2Dictionary
//
//  Created by MacOS on 22/09/2021.
//

import Foundation
import RxSwift

// MARK: - PatchDetail
public protocol PatchDetailUseCaseDomain {
    func loadHeroesPatchData(patchVersion: String) -> Observable<[PatchModel]>
    func loadItemsPatchData(patchVersion: String) -> Observable<[PatchModel]>
}

// MARK: - Hero
public protocol HeroUseCaseDomain {
    func loadStrengthData() -> Observable<[HeroModel]>
    func loadAgibilityData() -> Observable<[HeroModel]>
    func loadIntelligentData() -> Observable<[HeroModel]>
}

// MARK: - Item
public protocol ItemUseCaseDomain {
    func loadItemDataAtFirst() -> Observable<[String]>
}

// MARK: - Item Detail
public protocol ItemDetailUseCaseDomain {
    func loadItemDetailDataAtFirst(itemKey: String) -> Observable<ItemDetailModel>
}
