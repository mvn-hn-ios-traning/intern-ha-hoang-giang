//
//  ItemDetailViewModelPlus.swift
//  Dota2Dictionary
//
//  Created by MacOS on 14/10/2021.
//

import Foundation

final class ItemDetailViewModelPlus {
    
    let itemkey: String
    var imageLink: String {
        let imageLink = "https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/items/\(itemkey).png"
        return imageLink
    }
    
    let dname: String
    let cost: Int
    let hint: [String]
    var newHint: String {
        var newHint = ""
        for element in hint {
            let newElement = element.replacingOccurrences(of: ". ", with: ".\n")
            newHint.append(newElement + "\n\n")
        }
        return newHint
    }
    
    let coldown: ValueWrapper
    var newColdown: String {
        let new = coldown.rawValue
        return new
    }
    
    let manaCost: ValueWrapper
    var newManaCost: String {
        let new = manaCost.rawValue
        return new
    }
    let notes: String
    
    let attrib: [Attribute]
    var newAttrib: String {
        var new = ""
        for element in attrib {
            if let footer = element.footer {
                new.append(element.header + " " + element.value + " " + footer + "\n\n")
            } else {
                new.append(element.header + " " + element.value + " " + "\n\n")
            }
        }
        return new
    }
    
    let lore: String
    
    let components: [String]
    
    private let itemDetail: ItemDetailModel
    
    init(with item: ItemDetailModel) {
        self.itemDetail = item
        self.itemkey = item.itemKey
        self.dname = item.dname ?? "N/A"
        self.cost = item.cost ?? 0
        self.hint = item.hint ?? [String]()
        self.coldown = item.coldown ?? ValueWrapper.stringValue("N/A")
        self.manaCost = item.manaCost ?? ValueWrapper.stringValue("N/A")
        self.notes = item.notes.replacingOccurrences(of: "\n", with: "\n\n")
        self.attrib = item.attrib ?? [Attribute]()
        self.lore = item.lore
        self.components = item.components ?? [String]()
    }
    
}
