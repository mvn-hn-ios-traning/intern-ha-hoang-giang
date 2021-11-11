//
//  ItemLoreTableViewCell.swift
//  Dota2Dictionary
//
//  Created by MacOS on 01/11/2021.
//

import UIKit

class ItemLoreTableViewCell: UITableViewCell {
    
    @IBOutlet weak var loreLabel: UILabel!
    
    func configure(_ viewModel: ItemDetailViewModelPlus) {
        loreLabel.text = viewModel.lore
    }
    
}
