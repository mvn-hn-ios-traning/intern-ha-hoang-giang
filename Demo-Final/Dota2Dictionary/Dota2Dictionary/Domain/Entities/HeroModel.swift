//
//  HomeModel.swift
//  Dota2Dictionary
//
//  Created by MacOS on 22/09/2021.
//

import Foundation

public class HeroModel: NSObject {
    var theID: String = ""
    var name: String = ""
    var localizedName: String = ""
    var primaryAttr: String = ""
    var attackType: String = ""
    var roles: [String] = [""]
    
//    func initLoad(_ json: [String: Any]) -> HeroModel {
//        if let result = json["id"] as? Int {
//            theID = result
//        }
//        if let result = json["name"] as? String {
//            name = result
//        }
//        if let result = json["localized_name"] as? String {
//            localizedName = result
//        }
//        if let result = json["primary_attr"] as? String {
//            primaryAttr = result
//        }
//        if let result = json["attack_type"] as? String {
//            attackType = result
//        }
//        if let result = json["roles"] as? [String] {
//            roles = result
//        }
//        return self
//    }
}
