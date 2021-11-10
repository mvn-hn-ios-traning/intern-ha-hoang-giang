//
//  ItemHintTableViewCell.swift
//  Dota2Dictionary
//
//  Created by MacOS on 01/11/2021.
//

import UIKit

class ItemHintTableViewCell: UITableViewCell {
    
    @IBOutlet weak var hintLabel: UILabel!
    
    func configure(_ hint: ItemDetailViewModelPlus) {
        hintLabel.text = hint.newHint
    }
    
}
