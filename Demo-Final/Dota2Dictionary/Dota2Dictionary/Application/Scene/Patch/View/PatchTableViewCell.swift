//
//  PatchTableViewCell.swift
//  Dota2Dictionary
//
//  Created by MacOS on 06/10/2021.
//

import UIKit

class PatchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var patchName: UILabel!
    @IBOutlet weak var generalDetail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configure(_ viewModel: NewPatchDetailViewModel) {
        patchName.text = "Version: " + viewModel.newPatchName
        generalDetail.text = viewModel.newGeneral
    }
    
}
