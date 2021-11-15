//
//  HeroDetailUseCaseDomain.swift
//  Dota2Dictionary
//
//  Created by MacOS on 10/11/2021.
//

import Foundation
import RxSwift

// MARK: Hero Detail
public protocol HeroDetailUseCaseDomain {
    func loadHeroDetailDataAtFirst(heroID: String) -> Observable<HeroDetailModel>
    func loadHeroDetailRoles() -> Observable<[RolesDetail]>
    func loadHeroAbilityId() -> Observable<[String: String]>
    func loadHeroAbilities() -> Observable<[HeroDetailAbilitiesModel]>
}
