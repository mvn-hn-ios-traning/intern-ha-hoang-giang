//
//  NewPatchDetailViewModel.swift
//  Dota2Dictionary
//
//  Created by MacOS on 04/10/2021.
//

import Foundation

final class NewPatchDetailViewModel {
    
    private let patch: PatchModel
    
    var patchName: String
    var newPatchName: String
    
    var newGeneral: String {
        var newGen = ""
        for item in patch.general {
            newGen.append("* " + item + ". \n \n")
        }
       return newGen
    }
    
    var nameHeroItem: String
    var newHeroItemName: String
        
    var newHeroItemDetail: String {
        var newHero = ""
        for hero in patch.detailHeroItem {
            newHero.append("* " + hero + ". \n \n")
        }
        return newHero
    }
    
    var imageKey: String
    var sizeImg: String
    
    init (with patch: PatchModel) {
        self.patch = patch
        self.patchName = patch.patchName
        self.newPatchName = patch.patchName.replacingOccurrences(of: "_", with: ".")
        self.nameHeroItem = patch.nameHeroItem
        self.newHeroItemName = patch.nameHeroItem.replacingOccurrences(of: "_", with: " ").uppercased()
        self.imageKey = patch.imageKey
        self.sizeImg = patch.sizeImg
    }
        
}
