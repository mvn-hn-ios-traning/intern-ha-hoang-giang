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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ viewModel: ItemDetailViewModelPlus) {
        manaLabel.text = String(viewModel.newManaCost)
        coldownLabel.text = String(viewModel.newColdown)
        
    }
    
}
