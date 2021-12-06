//
//  HeroLikedModel.swift
//  Dota2Dictionary
//
//  Created by MacOS on 01/12/2021.
//

import Foundation

public struct HeroLikedModel {
    let heroId: String
    let localizedName: String
    let name: String
    
    init(dict: [String: Any]) {
        self.heroId = dict["id"] as? String ?? ""
        self.localizedName = dict["localizedName"] as? String ?? ""
        self.name = dict["name"] as? String ?? ""
    }
}
