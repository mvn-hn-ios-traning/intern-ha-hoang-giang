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
    func loadHeroAbilityId(heroNameOriginal: String) -> Observable<HeroAbilityMidman>
    func loadHeroAbilities() -> Observable<[HeroDetailAbilitiesModel]>
    func loadHeroLore() -> Observable<[String: String]>
    func like(heroID: String, state: Bool, data: HeroDetailViewModelPlus)
}
