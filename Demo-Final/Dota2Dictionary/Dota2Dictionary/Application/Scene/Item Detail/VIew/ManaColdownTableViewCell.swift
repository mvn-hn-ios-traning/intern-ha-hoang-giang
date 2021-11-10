//
//  ManaColdownTableViewCell.swift
//  Dota2Dictionary
//
//  Created by MacOS on 01/11/2021.
//

import UIKit

class ManaColdownTableViewCell: UITableViewCell {
    
    @IBOutlet weak var manaLabel: UILabel!
    @IBOutlet weak var coldownLabel: UILabel!
    
    func configure(_ viewModel: ItemDetailViewModelPlus) {
        manaLabel.text = String(viewModel.newManaCost)
        coldownLabel.text = String(viewModel.newColdown)
        
    }
    
}
