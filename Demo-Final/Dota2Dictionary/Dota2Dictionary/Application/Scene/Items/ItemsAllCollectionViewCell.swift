//
//  ItemsAllCollectionViewCell.swift
//  Dota2Dictionary
//
//  Created by MacOS on 10/10/2021.
//

import UIKit
import Kingfisher

class ItemsAllCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemAvatar: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bind(_ itemKey: String) {
        self.itemName.text = itemKey.replacingOccurrences(of: "_", with: " ").capitalized
        
        let url = URL(string:
                        "https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/items/\(itemKey).png")
        let processor = DownsamplingImageProcessor(size: itemAvatar.bounds.size)
        itemAvatar
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
