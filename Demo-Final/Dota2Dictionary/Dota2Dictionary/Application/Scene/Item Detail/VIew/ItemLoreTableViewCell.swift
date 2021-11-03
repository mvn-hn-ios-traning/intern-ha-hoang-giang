//
//  ItemLoreTableViewCell.swift
//  Dota2Dictionary
//
//  Created by MacOS on 01/11/2021.
//

import UIKit

class ItemLoreTableViewCell: UITableViewCell {
    @IBOutlet weak var loreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ viewModel: ItemDetailViewModelPlus) {
        loreLabel.text = viewModel.lore
    }
    
}
