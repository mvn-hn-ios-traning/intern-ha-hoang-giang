//
//  InfoTopTableViewCell.swift
//  Dota2Dictionary
//
//  Created by MacOS on 31/10/2021.
//

import UIKit
import Kingfisher

class InfoTopTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemAvatar: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemCost: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(_ info: ItemDetailViewModelPlus) {
        // download image from url with kingfisher
        let url = URL(string: ConstantsForImageURL.itemImageForItemVC + "\(info.itemkey).png")
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
        
        itemName.text = info.dname
        itemCost.text = String(info.cost)
    }
    
}
