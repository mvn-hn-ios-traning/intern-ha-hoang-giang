//
//  ProfileLikeTableViewCell.swift
//  Dota2Dictionary
//
//  Created by MacOS on 23/11/2021.
//

import UIKit
import Kingfisher

class ProfileLikeTableViewCell: UITableViewCell {

    @IBOutlet weak var localizedName: UILabel!
    @IBOutlet weak var heroAvatar: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        heroAvatar.image = nil
    }
    
    func configure(_ model: HeroLikedModel) {
        self.localizedName.text = model.localizedName
        
        let newName = model.name.replacingOccurrences(of: "npc_dota_hero_", with: "")
        
        // download image from url with kingfisher
        let url = URL(string: ConstantsForImageURL.heroDetailAvatarImage + "\(newName).png")
        let processor = DownsamplingImageProcessor(size: heroAvatar.bounds.size)
        KF.url(url)
          .placeholder(UIImage(named: "placeholderImage"))
          .setProcessor(processor)
          .loadDiskFileSynchronously()
          .cacheMemoryOnly()
          .fade(duration: 0.25)
          .onProgress { _, _ in  }
          .onSuccess { _ in  }
          .onFailure { _ in }
          .set(to: heroAvatar)
    }
    
}
