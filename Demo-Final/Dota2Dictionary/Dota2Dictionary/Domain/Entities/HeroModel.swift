//
//  HomeModel.swift
//  Dota2Dictionary
//
//  Created by MacOS on 22/09/2021.
//

import Foundation

public class HeroModel: NSObject {
    var heroID: Int = 0
    var name: String = ""
    var localizedName: String = ""
    var primaryAttr: String = ""
    var attackType: String = ""
    var roles: [String] = [""]
}
