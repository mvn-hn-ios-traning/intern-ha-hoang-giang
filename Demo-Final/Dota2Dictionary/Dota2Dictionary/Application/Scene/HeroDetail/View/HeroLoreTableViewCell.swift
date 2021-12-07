//
//  HeroLoreTableViewCell.swift
//  Dota2Dictionary
//
//  Created by MacOS on 09/11/2021.
//

import UIKit
import Kingfisher

class HeroLoreTableViewCell: UITableViewCell {

    @IBOutlet weak var loreLabel: UILabel!

    func configure(_ viewModel: HeroDetailViewModelPlus) {
        loreLabel.text = viewModel.bio
    }
    
}
