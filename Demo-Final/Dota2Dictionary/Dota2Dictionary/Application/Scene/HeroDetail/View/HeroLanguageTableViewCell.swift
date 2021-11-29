//
//  HeroLanguageTableViewCell.swift
//  Dota2Dictionary
//
//  Created by MacOS on 04/11/2021.
//

import UIKit

class HeroLanguageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var hypeLabel: UILabel!
    
    func configure(_ viewModel: HeroDetailViewModelPlus) {
        self.hypeLabel.text = "Stat"
    }
}
