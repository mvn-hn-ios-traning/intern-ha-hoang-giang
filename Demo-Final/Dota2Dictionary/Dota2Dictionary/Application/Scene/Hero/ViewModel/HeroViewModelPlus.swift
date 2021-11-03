//
//  HeroViewModelPlus.swift
//  Dota2Dictionary
//
//  Created by MacOS on 29/09/2021.
//

import Foundation

final class HeroViewModelPlus {
    
    let heroID: Int
    var newID: String {
        return String(heroID)
    }
    
    let heroAvatar: String
    let heroName: String
    let hero: HeroModel
    
    init (with hero: HeroModel) {
        self.hero = hero
        self.heroID = hero.heroID
        self.heroName = hero.name
            .replacingOccurrences(of: "npc_dota_hero_", with: "")
            .replacingOccurrences(of: "_", with: " ")
            .capitalized
        self.heroAvatar = hero.name.replacingOccurrences(of: "npc_dota_hero_", with: "")
    }
}
