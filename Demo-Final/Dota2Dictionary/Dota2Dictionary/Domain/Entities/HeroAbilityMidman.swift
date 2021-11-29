//
//  HeroAbilityMidman.swift
//  Dota2Dictionary
//
//  Created by MacOS on 26/11/2021.
//

import Foundation

// MARK: - Talent
struct Talent: Codable {
    let name: String?
    let level: Int?
}

// MARK: - HeroAbilityMidman
public struct HeroAbilityMidman: Codable {
    let heroName: String
    
    let abilities: [String]?
    let talents: [Talent]?
    
    enum CodingKeys: String, CodingKey {
        case abilities, talents
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        heroName = container.codingPath.first!.stringValue
        abilities = try container.decodeIfPresent([String].self, forKey: .abilities)
        talents = try container.decodeIfPresent([Talent].self, forKey: .talents)
    }
}

struct AbilityDecodeArray: Codable {
    var array: [HeroAbilityMidman]
    
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
        
        var tempArray = [HeroAbilityMidman]()
        // 2
        // Loop through each key (item ID) in container
        for key in container.allKeys {
            
            // Decode using key & keep decoded object in tempArray
            let decodedObject = try container.decode(HeroAbilityMidman.self,
                                                     forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            tempArray.append(decodedObject)
        }
        // 3
        // Finish decoding all Item objects. Thus assign tempArray to array.
        array = tempArray
    }
}
