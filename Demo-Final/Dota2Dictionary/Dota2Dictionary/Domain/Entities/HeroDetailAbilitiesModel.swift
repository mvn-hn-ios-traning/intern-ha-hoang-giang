//
//  HeroDetailAbilitiesModel.swift
//  Dota2Dictionary
//
//  Created by MacOS on 07/11/2021.
//

import Foundation

struct AttributeSkill: Codable {
    var key: String
    var header: String
    var value: ValueWrapper
    var generated: Bool?
}

public struct HeroDetailAbilitiesModel: Codable {
    let abilitiesKey: String
    
    let dname: String?
    let desc: String?
    let behavior: ValueWrapper?
    let manaCost: ValueWrapper?
    let coldown: ValueWrapper?
    let dmgType: String?
    let bkbPierce: String?
    let attrib: [AttributeSkill]?
    
    enum CodingKeys: String, CodingKey {
        case dname
        case desc
        case behavior
        case manaCost = "mc"
        case coldown = "cd"
        case dmgType = "dmg_type"
        case bkbPierce = "bkbpierce"
        case attrib
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        abilitiesKey = container.codingPath.first!.stringValue
        
        dname = try container.decodeIfPresent(String.self, forKey: .dname)
        desc  = try container.decodeIfPresent(String.self, forKey: .desc)
        behavior = try container.decodeIfPresent(ValueWrapper.self, forKey: .behavior)
        manaCost = try container.decodeIfPresent(ValueWrapper.self, forKey: .manaCost)
        coldown  = try container.decodeIfPresent(ValueWrapper.self, forKey: .coldown)
        dmgType = try container.decodeIfPresent(String.self, forKey: .dmgType)
        bkbPierce = try container.decodeIfPresent(String.self, forKey: .bkbPierce)
        let attributeNull = try container.decodeIfPresent([OptionalObject<AttributeSkill>].self, forKey: .attrib)
        attrib = attributeNull?.compactMap({ $0.value })
    }
}

struct HeroAbilitiesArratDecoded: Codable {
    var array: [HeroDetailAbilitiesModel]
    
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
        
        var tempArray = [HeroDetailAbilitiesModel]()
        // 2
        // Loop through each key (item ID) in container
        for key in container.allKeys {
            
            // Decode using key & keep decoded object in tempArray
            let decodedObject = try container.decode(HeroDetailAbilitiesModel.self,
                                                     forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            tempArray.append(decodedObject)
        }
        // 3
        // Finish decoding all Item objects. Thus assign tempArray to array.
        array = tempArray
    }
}
