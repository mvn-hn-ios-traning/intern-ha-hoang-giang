//
//  ItemNotesTableViewCell.swift
//  Dota2Dictionary
//
//  Created by MacOS on 01/11/2021.
//

import UIKit

class ItemNotesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var noteLabel: UILabel!
    
    func configure(_ viewModel: ItemDetailViewModelPlus) {
        noteLabel.text = viewModel.notes
    }
    
}
