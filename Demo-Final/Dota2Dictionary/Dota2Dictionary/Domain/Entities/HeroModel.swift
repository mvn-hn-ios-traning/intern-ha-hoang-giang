//
//  HomeModel.swift
//  Dota2Dictionary
//
//  Created by MacOS on 22/09/2021.
//

import Foundation

class HeroModel: NSObject {
    var theID: Int = 0
    var name: String = ""
    var localizedName: String = ""
    var primaryAttr: String = ""
    var attackYype: String = ""
    var roles: [String] = [""]
    
    func initLoad(_ json: [String: Any]) -> HeroModel {
        if let temp = json["id"] as? Int {
            theID = temp
        }
        if let temp = json["name"] as? String {
            name = temp
        }
        if let temp = json["localized_name"] as? String {
            localizedName = temp
        }
        if let temp = json["primary_attr"] as? String {
            primaryAttr = temp
        }
        if let temp = json["attack_type"] as? String {
            attackYype = temp
        }
        if let temp = json["roles"] as? [String] {
            roles = temp
        }
        return self
    }
}
