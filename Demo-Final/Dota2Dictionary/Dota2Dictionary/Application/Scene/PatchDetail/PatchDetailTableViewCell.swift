//
//  PatchDetailTableViewCell.swift
//  Dota2Dictionary
//
//  Created by MacOS on 06/10/2021.
//

import UIKit
import Kingfisher

class PatchDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemDetail: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    let urlKey = "http://cdn.dota2.com/apps/dota2/images/"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(model: NewPatchDetailViewModel) {
        self.itemName.text = model.newHeroName
        self.itemDetail.text = model.newHeroDetail
        
        let url = URL(string: "\(urlKey)\(model.imageKey)/\(model.heroName)_\(model.sizeImg).png")
        let processor = DownsamplingImageProcessor(size: avatar.bounds.size)
        avatar
            .kf
            .setImage(
                with: url,
                placeholder: UIImage(named: "placeholderImage"),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
    }
}