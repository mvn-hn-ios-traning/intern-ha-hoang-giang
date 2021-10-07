//
//  PatchModel.swift
//  Dota2Dictionary
//
//  Created by MacOS on 04/10/2021.
//

import Foundation

public class PatchModel: NSObject {
    var patchName: String = ""
    var general: [String] = [""]
    var item: String = ""
    var itemDetail: [String] = [""]
    var hero: String = ""
    var heroDetail: [String] = [""]
    
    func initLoad(_ json: [String: Any]) -> PatchModel {
        
        return self
    }
}
