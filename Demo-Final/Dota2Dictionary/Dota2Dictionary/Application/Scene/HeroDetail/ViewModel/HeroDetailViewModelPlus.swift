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
    let abilityIDs: [String: String]
    let abilitiesDetail: [HeroDetailAbilitiesModel]
    
    var abilityKey: [String] {
        var abilityKey = [String]()
        for each in abilities {
            let result = abilityIDs.filter { $0.key == String(each.abilityId) && $0.key != String(6251) }
            abilityKey.append(contentsOf: result.values)
        }
        return abilityKey
    }
    
    var abilitiesDetailResult: [HeroDetailAbilitiesModel] {
        var result = [HeroDetailAbilitiesModel]()
        for each in abilityKey {
            let forResult = abilitiesDetail.filter { $0.abilitiesKey == each }
            result.append(forResult.first!)
        }
        return result
    }
    
    let roles: [Roles]
    let rolesDetail: [RolesDetail]
    
    var resulrRolesDetail: [RolesDetail] {
        var arrayResult = [RolesDetail]()
        for each in roles {
            let result = rolesDetail.filter { $0.roleId == each.roleId }
            arrayResult.append(result.first!)
        }
        return arrayResult
    }
    
    let talents: [Talents]
    var talentsString: [String] {
        var result = [String]()
        for each in talents {
            let resultNew = abilityIDs.filter { $0.key == String(each.abilityId) }
            result.append(contentsOf: resultNew.values)
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
    
    let stat: Stat
    let language: Language
    
    private let heroDetail: HeroDetailModel
    
    init(hero: HeroDetailModel,
         roles: [RolesDetail],
         abilityIDs: [String: String],
         abilitiesDetail: [HeroDetailAbilitiesModel]) {
        self.heroDetail = hero
        self.heroID = hero.heroID
        self.displayName = hero.displayName
        self.shortName = hero.shortName
        
        self.abilities = hero.abilities
        self.abilityIDs = abilityIDs
        self.abilitiesDetail = abilitiesDetail
        
        self.roles = hero.roles
        self.rolesDetail = roles
        self.talents = hero.talents
        self.stat = hero.stat
        self.language = hero.language
    
    }
}
