//
//  ManaColdownTableViewCell.swift
//  Dota2Dictionary
//
//  Created by MacOS on 01/11/2021.
//

import UIKit

class ManaColdownTableViewCell: UITableViewCell {
    
    @IBOutlet weak var manaLabel: UILabel!
    @IBOutlet weak var manaIcon: UIImageView!
    @IBOutlet weak var coldownLabel: UILabel!
    @IBOutlet weak var coldownIcon: UIImageView!
    
    func configure(_ viewModel: ItemDetailViewModelPlus) {
        manaLabel.text = String(viewModel.newManaCost)
        coldownLabel.text = String(viewModel.newColdown)
        
        if viewModel.newManaCost == "false" {
            manaLabel.isHidden = true
            manaIcon.isHidden = true
        }
        if viewModel.newColdown == "false" {
            coldownIcon.isHidden = true
            coldownLabel.isHidden = true
        }
    }
    
}
