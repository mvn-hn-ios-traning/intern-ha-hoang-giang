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
    var nameHeroItem: String = ""
    var detailHeroItem: [String] = [""]
    var imageKey: String = ""
    var sizeImg: String = ""
    
    func initLoad(_ json: [String: Any]) -> PatchModel {
        
        return self
    }
}
