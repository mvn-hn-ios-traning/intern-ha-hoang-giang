//
//  HeroDetailViewModelPlus.swift
//  Dota2Dictionary
//
//  Created by MacOS on 08/10/2021.
//

import Foundation

class HeroDetailViewModelPlus {
    let displayName: String
    
    init(with hero: HeroDetail) {
        self.displayName = hero.displayName
    }
}
