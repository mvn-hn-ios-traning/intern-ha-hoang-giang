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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(model: NewPatchDetailViewModel) {
        let url = URL(string: "http://cdn.dota2.com/apps/dota2/images/items/\(model.itemName)_lg.png")
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
