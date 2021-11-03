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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemAvatar.image = nil
    }

    func bind(_ itemKey: String) {
        self.itemName.text = itemKey.replacingOccurrences(of: "_", with: " ").capitalized
        
        let url = URL(string:
                        "\(ConstantsForImageURL.itemImageForItemVC)\(itemKey).png")
        let processor = DownsamplingImageProcessor(size: itemAvatar.bounds.size)
        
        KF.url(url)
          .placeholder(UIImage(named: "placeholderImage"))
          .setProcessor(processor)
          .loadDiskFileSynchronously()
          .cacheMemoryOnly()
          .fade(duration: 0.25)
          .onProgress { _, _ in  }
          .onSuccess { _ in  }
          .onFailure { _ in }
          .set(to: itemAvatar)
        
    }
}
