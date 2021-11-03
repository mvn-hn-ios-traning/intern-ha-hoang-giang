//
//  HeroDetailViewModelPlus.swift
//  Dota2Dictionary
//
//  Created by MacOS on 08/10/2021.
//

import Foundation

class HeroDetailViewModelPlus {    
    
    let heroID: String
    
    let displayName: String
    let shortName: String
    
    let abilities: [Abilities]
    let roles: [Roles]
        
    let talents: [Talents]
    let stat: Stat
    let language: Language
    
    private let heroDetail: HeroDetailModel
    
    init(with hero: HeroDetailModel) {
        self.heroDetail = hero
        self.heroID = hero.heroID
        self.displayName = hero.displayName
        self.shortName = hero.shortName
        self.abilities = hero.abilities
        self.roles = hero.roles
        self.talents = hero.talents
        self.stat = hero.stat
        self.language = hero.language
    }
}
