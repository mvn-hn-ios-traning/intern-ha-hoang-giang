//
//  UseCaseDomain.swift
//  Dota2Dictionary
//
//  Created by MacOS on 22/09/2021.
//

import Foundation
import RxSwift

// MARK: - Patch
public protocol PatchUseCaseDomain {
    func loadPatchDataAllFirst() -> Observable<[PatchModel]>
}

// MARK: - PatchDetail
public protocol PatchDetailUseCaseDomain {
    func loadHeroesPatchData(patchVersion: String) -> Observable<[PatchModel]>
    func loadItemsPatchData(patchVersion: String) -> Observable<[PatchModel]>
}

// MARK: - Hero
public protocol HeroUseCaseDomain {
    func loadDataAtFirst() -> Observable<[HeroModel]>
}

// MARK: Hero Detail
public protocol HeroDetailUseCaseDomain {
    func loadHeroDetailDataAtFirst(heroID: String) -> Observable<HeroDetailModel>
    func loadHeroDetailRoles() -> Observable<[RolesDetail]>
    func loadHeroAbilityId() -> Observable<[String: String]>
    func loadHeroAbilities() -> Observable<[HeroDetailAbilitiesModel]>
}

// MARK: - Item
public protocol ItemUseCaseDomain {
    func loadItemDataAtFirst() -> Observable<[String]>
}

// MARK: - Item Detail
public protocol ItemDetailUseCaseDomain {
    func loadItemDetailDataAtFirst(itemKey: String) -> Observable<ItemDetailModel>
}