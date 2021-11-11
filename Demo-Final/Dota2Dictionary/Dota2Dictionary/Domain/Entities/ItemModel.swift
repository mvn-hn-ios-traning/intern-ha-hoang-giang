//
//  ItemModel.swift
//  Dota2Dictionary
//
//  Created by MacOS on 10/10/2021.
//

import Foundation

struct ItemModel: Codable {
    var array: [String]
    
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
        
        var tempArray = [String]()
        
        // 2
        // Loop through each key (item ID) in container
        for key in container.allKeys {
            
            // Decode using key & keep decoded object in tempArray
            let decodedObject = try container.decode(String.self,
                                                     forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            tempArray.append(decodedObject)
        }
        
        // 3
        // Finish decoding all Item objects. Thus assign tempArray to array.
        array = tempArray
    }
}
