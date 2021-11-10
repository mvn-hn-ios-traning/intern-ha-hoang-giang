//
//  HeroTalentsTableViewCell.swift
//  Dota2Dictionary
//
//  Created by MacOS on 07/11/2021.
//

import UIKit

class HeroTalentsTableViewCell: UITableViewCell {

    @IBOutlet weak var talentText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(_ viewModel: HeroDetailViewModelPlus) {
        
        talentText.text = viewModel.talentResultText
    }
    
}
