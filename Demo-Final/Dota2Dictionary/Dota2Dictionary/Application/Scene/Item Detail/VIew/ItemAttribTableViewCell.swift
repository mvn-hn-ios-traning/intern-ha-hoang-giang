//
//  ItemAttribTableViewCell.swift
//  Dota2Dictionary
//
//  Created by MacOS on 01/11/2021.
//

import UIKit

class ItemAttribTableViewCell: UITableViewCell {
    
    @IBOutlet weak var attribLabel: UILabel!
    
    func configure(_ viewModel: ItemDetailViewModelPlus) {
        attribLabel.text = viewModel.newAttrib
    }
    
}
