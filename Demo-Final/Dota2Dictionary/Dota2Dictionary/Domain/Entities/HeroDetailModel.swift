//
//  HeroDetailModel.swift
//  Dota2Dictionary
//
//  Created by MacOS on 08/10/2021.
//

import Foundation

public struct HeroDetailModel: Codable {
    let heroID: String
    
    let id: Int?
    let name, localizedName: String?
    let primaryAttr: String?
    let attackType: String?
    let roles: [String]?
    let baseHealth: Int?
    let baseHealthRegen: Double?
    let baseMana: Int?
    let baseManaRegen, baseArmor: Double?
    let baseMr, baseAttackMin, baseAttackMax, baseStr: Int?
    let baseAgi, baseInt: Int?
    let strGain, agiGain, intGain: Double?
    let attackRange: Int?
    let attackRate: Double?
    let moveSpeed: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case localizedName = "localized_name"
        case primaryAttr = "primary_attr"
        case attackType = "attack_type"
        case roles
        case baseHealth = "base_health"
        case baseHealthRegen = "base_health_regen"
        case baseMana = "base_mana"
        case baseManaRegen = "base_mana_regen"
        case baseArmor = "base_armor"
        case baseMr = "base_mr"
        case baseAttackMin = "base_attack_min"
        case baseAttackMax = "base_attack_max"
        case baseStr = "base_str"
        case baseAgi = "base_agi"
        case baseInt = "base_int"
        case strGain = "str_gain"
        case agiGain = "agi_gain"
        case intGain = "int_gain"
        case attackRange = "attack_range"
        case attackRate = "attack_rate"
        case moveSpeed = "move_speed"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        heroID = container.codingPath.first!.stringValue
        
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        localizedName = try container.decodeIfPresent(String.self, forKey: .localizedName)
        primaryAttr = try container.decodeIfPresent(String.self, forKey: .primaryAttr)
        attackType = try container.decodeIfPresent(String.self, forKey: .attackType)
        roles = try container.decodeIfPresent([String].self, forKey: .roles)
        baseHealth = try container.decodeIfPresent(Int.self, forKey: .baseHealth)
        baseHealthRegen = try container.decodeIfPresent(Double.self, forKey: .baseHealthRegen)
        baseMana = try container.decodeIfPresent(Int.self, forKey: .baseMana)
        baseManaRegen = try container.decodeIfPresent(Double.self, forKey: .baseManaRegen)
        baseArmor = try container.decodeIfPresent(Double.self, forKey: .baseArmor)
        baseMr = try container.decodeIfPresent(Int.self, forKey: .baseMr)
        baseAttackMin = try container.decodeIfPresent(Int.self, forKey: .baseAttackMin)
        baseAttackMax = try container.decodeIfPresent(Int.self, forKey: .baseAttackMax)
        baseStr = try container.decodeIfPresent(Int.self, forKey: .baseStr)
        baseAgi = try container.decodeIfPresent(Int.self, forKey: .baseAgi)
        baseInt = try container.decodeIfPresent(Int.self, forKey: .baseInt)
        strGain = try container.decodeIfPresent(Double.self, forKey: .strGain)
        agiGain = try container.decodeIfPresent(Double.self, forKey: .agiGain)
        intGain = try container.decodeIfPresent(Double.self, forKey: .intGain)
        attackRange = try container.decodeIfPresent(Int.self, forKey: .attackRange)
        attackRate = try container.decodeIfPresent(Double.self, forKey: .attackRate)
        moveSpeed = try container.decodeIfPresent(Int.self, forKey: .moveSpeed)
    }
    
}

struct HeroDetailDecodeArray: Codable {
    var array: [HeroDetailModel]
    
    private struct DynamicCodingKeys: CodingKey {
        // Use for string-keyed dictionary
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        // Use for integer-keyed dictionary
        var intValue: Int?
        init?(intValue: Int) {
            // We are not using this, thus just return nil
            return nil
        }
    }
    
    init(from decoder: Decoder) throws {
        // 1
        // Create a decoding container using DynamicCodingKeys
        // The container will contain all the JSON first level key
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        var tempArray = [HeroDetailModel]()
        // 2
        // Loop through each key (item ID) in container
        for key in container.allKeys {
            
            // Decode using key & keep decoded object in tempArray
            let decodedObject = try container.decode(HeroDetailModel.self,
                                                     forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            tempArray.append(decodedObject)
        }
        // 3
        // Finish decoding all Item objects. Thus assign tempArray to array.
        array = tempArray
    }
}
