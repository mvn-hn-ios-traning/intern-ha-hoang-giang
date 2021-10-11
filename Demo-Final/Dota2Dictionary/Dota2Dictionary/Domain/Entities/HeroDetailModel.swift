//
//  HeroDetailModel.swift
//  Dota2Dictionary
//
//  Created by MacOS on 08/10/2021.
//

import Foundation

struct Language: Codable {
    var bio: String
    var hype: String
}

struct Stat: Codable {
    var attackType: String
    var startingArmor: Int
    var startingMagicArmor: Int
    var startingDamageMin: Int
    var startingDamageMax: Int
    var attackRate: Int
    var attackRange: Int
    var primaryAttribute: String
    var strengthBase: Int
    var strengthGain: Int
    var intelligenceBase: Int
    var intelligenceGain: Int
    var agilityBase: Int
    var agilityGain: Int
    var hpRegen: Int
    var mpRegen: Int
    var moveSpeed: Int
    var moveTurnRate: Int
    var visionDaytimeRange: Int
    var visionNighttimeRange: Int
    var complexity: Int
}

struct Talents: Codable {
    var slot: Int
    var abilityId: Int
}

struct Roles: Codable {
    var roleId: Int
    var level: Int
}

struct Abileties: Codable {
    var slot: Int
    var abilityId: Int
}

struct HeroDetail: Codable {
    var theId: Int
    var name: String
    var displayName: String
    var shortName: String
    var abilities: [Abileties]
    var roles: [Roles]
    var talents: [Talents]
    var stat: Stat
    var language: Language
}

struct HeroDetailModel: Codable {
    var heroDetail: HeroDetail
}
