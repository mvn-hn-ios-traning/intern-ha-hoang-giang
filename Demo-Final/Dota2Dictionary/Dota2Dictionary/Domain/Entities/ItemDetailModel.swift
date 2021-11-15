//
//  ItemDetailModel.swift
//  Dota2Dictionary
//
//  Created by MacOS on 10/10/2021.
//

import Foundation

struct Attribute: Codable {
    let key: String
    let header: String
    let value: String
    let footer: String?
}

public struct ItemDetailModel: Codable {
    let itemKey: String
    
    let hint: [String]?
    let dname: String?
    let qual: String?
    let cost: Int?
    let notes: String
    let attrib: [Attribute]?
    let manaCost: ValueWrapper?
    let coldown: ValueWrapper?
    let lore: String
    let components: [String]?
    
    enum CodingKeys: String, CodingKey {
        case hint
        case dname
        case qual
        case cost
        case notes
        case attrib
        case manaCost = "mc"
        case coldown = "cd"
        case lore
        case components
    }
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        itemKey = container.codingPath.first!.stringValue
        
        hint = try container.decodeIfPresent([String].self, forKey: .hint)
        
        dname = try container.decodeIfPresent(String.self, forKey: .dname)
        
        qual = try container.decodeIfPresent(String.self, forKey: .qual)
        
        cost = try container.decodeIfPresent(Int.self, forKey: .cost)
        
        notes = try container.decode(String.self, forKey: .notes)
        
        let attributeNull = try container.decodeIfPresent([OptionalObject<Attribute>].self, forKey: .attrib)
        attrib = attributeNull?.compactMap({ $0.value })
        
        manaCost = try container.decodeIfPresent(ValueWrapper.self, forKey: .manaCost)
        
        coldown = try container.decodeIfPresent(ValueWrapper.self, forKey: .coldown)
        
        lore = try container.decode(String.self, forKey: .lore)
        
        components = try container.decodeIfPresent([String].self, forKey: .components)
        
    }
}

struct ItemDetailDecodeArray: Codable {
    var array: [ItemDetailModel]
    
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
        
        var tempArray = [ItemDetailModel]()
        // 2
        // Loop through each key (item ID) in container
        for key in container.allKeys {
            
            // Decode using key & keep decoded object in tempArray
            let decodedObject = try container.decode(ItemDetailModel.self,
                                                     forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            tempArray.append(decodedObject)
        }
        // 3
        // Finish decoding all Item objects. Thus assign tempArray to array.
        array = tempArray
    }
}
