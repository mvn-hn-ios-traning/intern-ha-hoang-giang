//
//  ProfileLikeTableViewCell.swift
//  Dota2Dictionary
//
//  Created by MacOS on 23/11/2021.
//

import UIKit

class ProfileLikeTableViewCell: UITableViewCell {

    @IBOutlet weak var localizedName: UILabel!
    
    func configure(_ model: HeroLikedModel) {
        self.localizedName.text = model.localizedName
    }
    
}
