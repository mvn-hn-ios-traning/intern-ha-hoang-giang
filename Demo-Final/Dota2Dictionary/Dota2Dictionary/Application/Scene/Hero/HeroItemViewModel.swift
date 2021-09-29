//
//  HeroItemViewModel.swift
//  Dota2Dictionary
//
//  Created by MacOS on 29/09/2021.
//

import Foundation

final class HeroItemViewModel {
    let heroAvatar: String
    let heroName: String
    let hero: HeroModel
    
    init (with hero: HeroModel) {
        self.hero = hero
        self.heroName = hero.localizedName
        self.heroAvatar = hero.name.replacingOccurrences(of: "npc_dota_hero_", with: "")
    }
}
