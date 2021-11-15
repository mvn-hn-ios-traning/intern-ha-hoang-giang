//
//  HeroLanguageTableViewCell.swift
//  Dota2Dictionary
//
//  Created by MacOS on 04/11/2021.
//

import UIKit

class HeroLanguageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var hypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ viewModel: HeroDetailViewModelPlus) {
        hypeLabel.text = viewModel.language.hype.htmlToString
    }
}
