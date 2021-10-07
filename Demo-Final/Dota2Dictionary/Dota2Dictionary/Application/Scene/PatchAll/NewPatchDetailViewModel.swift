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
    
    var itemName: String
    var newItemName: String
        
    var newItemDetail: String {
        var newItem = ""
        for item in patch.itemDetail {
            newItem.append("* " + item + ". \n \n")
        }
        return newItem
    }
    
    var heroName: String
    var newHeroName: String
        
    var newHeroDetail: String {
        var newHero = ""
        for hero in patch.heroDetail {
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
        self.itemName = patch.item
        self.newItemName = patch.item.replacingOccurrences(of: "_", with: " ").uppercased()
        self.heroName = patch.hero
        self.newHeroName = patch.hero.replacingOccurrences(of: "_", with: " ").uppercased()
        self.imageKey = patch.imageKey
        self.sizeImg = patch.sizeImg
    }
        
}
