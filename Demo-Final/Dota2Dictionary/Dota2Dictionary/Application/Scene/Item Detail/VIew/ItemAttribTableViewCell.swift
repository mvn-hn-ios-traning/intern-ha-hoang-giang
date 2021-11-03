//
//  ItemAttribTableViewCell.swift
//  Dota2Dictionary
//
//  Created by MacOS on 01/11/2021.
//

import UIKit

class ItemAttribTableViewCell: UITableViewCell {
    @IBOutlet weak var attribLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ viewModel: ItemDetailViewModelPlus) {
        attribLabel.text = viewModel.newAttrib
    }
    
}
