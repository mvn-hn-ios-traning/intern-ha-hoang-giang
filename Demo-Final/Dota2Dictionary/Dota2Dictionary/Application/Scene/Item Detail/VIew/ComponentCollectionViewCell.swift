//
//  ComponentCollectionViewCell.swift
//  Dota2Dictionary
//
//  Created by MacOS on 01/11/2021.
//

import UIKit
import Kingfisher

class ComponentCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ element: String) {
        itemName.text = element.replacingOccurrences(of: "_", with: " ").capitalized
        
        // download image from url with kingfisher
        let url = URL(string: ConstantsForImageURL.itemImageForItemVC + "\(element).png")
        let processor = DownsamplingImageProcessor(size: itemImage.bounds.size)
        KF.url(url)
          .placeholder(UIImage(named: "placeholderImage"))
          .setProcessor(processor)
          .loadDiskFileSynchronously()
          .cacheMemoryOnly()
          .fade(duration: 0.25)
          .onProgress { _, _ in  }
          .onSuccess { _ in  }
          .onFailure { _ in }
          .set(to: itemImage)
    }

}
