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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatar.image = nil
    }
    
    func configure(model: NewPatchDetailViewModel) {
        self.itemName.text = model.newHeroItemName
        self.itemDetail.text = model.newHeroItemDetail
        
        let imageKey = model.imageKey
        let nameHeroItem = model.nameHeroItem
        let sizeImg = model.sizeImg
        let url = URL(string: "\(ConstantsForImageURL.patchImage)\(imageKey)/\(nameHeroItem)_\(sizeImg).png")
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
