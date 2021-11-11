//
//  HeroDetailRolesModel.swift
//  Dota2Dictionary
//
//  Created by MacOS on 02/11/2021.
//

import Foundation

public struct RolesDetail: Codable {
    let roleId: Int
    let roleName: String
    
    enum CodingKeys: String, CodingKey {
        case roleId = "id"
        case roleName = "name"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        roleId = try container.decode(Int.self, forKey: .roleId)
        roleName = try container.decode(String.self, forKey: .roleName)
    }
}
