//
//  HeroDetailViewModelPlus.swift
//  Dota2Dictionary
//
//  Created by MacOS on 08/10/2021.
//

import Foundation

class HeroDetailViewModelPlus {    
    let heroDetail: HeroDetailModel
    
    let heroID: String
    
    let localizedName: String?
    let name: String?
    
    var shortName: String {
        var name = ""
        guard let newName = self.name else { return "" }
        name = newName.replacingOccurrences(of: "npc_dota_hero_", with: "")
        return name
    }
    
    let roles: [String]?
    
    let ability: HeroAbilityMidman
    let abilitiesDetail: [HeroDetailAbilitiesModel]
    
    var abilitiesDetailResult: [HeroDetailAbilitiesModel] {
        var result = [HeroDetailAbilitiesModel]()
        guard let abilities = ability.abilities else { return result }
        let newAbilities = abilities.filter { $0 != "generic_hidden" }
        for each in newAbilities {
            let forResult = abilitiesDetail.filter { $0.abilitiesKey == each }
            result.append(forResult.first!)
        }
        return result
    }
    
    let talents: [Talent]?
    var talentsString: [String] {
        var result = [String]()
        guard let talents = self.talents else { return [""] }
        for each in talents {
            var resultNew: String {
                var talentResult = ""
                guard let newName = each.name else { return "" }
                talentResult = newName
                return talentResult
            }
            result.append(resultNew)
        }
        return result
    }
    var abilitiesTalents: [HeroDetailAbilitiesModel] {
        var result = [HeroDetailAbilitiesModel]()
        for each in talentsString {
            let forResult = abilitiesDetail.filter {$0.abilitiesKey == each}
            result.append(forResult.first!)
        }
        return result
    }
    var talentResultText: String {
        var result = ""
        var talentLevel = 10
        var numberKey = 0
        
        for each in abilitiesTalents {
            if numberKey % 2 == 0 {
                result.append("TALENT LEVEL \(talentLevel): \n \t" + (each.dname ?? "") + "\n")
                talentLevel += 5
                numberKey += 1
            } else {
                result.append("\t" + (each.dname ?? "") + "\n\n")
                numberKey += 1
            }
        }
        return result
    }
    
    let heroLore: [String: String]
    
    var bio: String {
        var bio = ""
        guard let newBio = self.heroLore[shortName] else {
            return "Not available"
        }
        bio = newBio
        return bio
    }
    
    init(hero: HeroDetailModel,
         ability: HeroAbilityMidman,
         abilitiesDetail: [HeroDetailAbilitiesModel],
         lore: [String: String]) {
        
        self.heroDetail = hero
        self.heroID = hero.heroID
        
        self.localizedName = hero.localizedName
        
        self.name = hero.name
        
        self.roles = hero.roles
        
        self.ability = ability
        
        self.abilitiesDetail = abilitiesDetail
        
        self.talents = ability.talents
        
        self.heroLore = lore
        
    }
}
