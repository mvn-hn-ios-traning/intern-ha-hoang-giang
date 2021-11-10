//
//  HeroLoreTableViewCell.swift
//  Dota2Dictionary
//
//  Created by MacOS on 09/11/2021.
//

import UIKit
import Kingfisher

class HeroLoreTableViewCell: UITableViewCell {

    @IBOutlet weak var heroSefie: UIImageView!
    @IBOutlet weak var loreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(_ viewModel: HeroDetailViewModelPlus) {
        // download image from url with kingfisher
        let url = URL(string: ConstantsForImageURL.heroSelfie + viewModel.shortName + ".jpg")
        let processor = DownsamplingImageProcessor(size: heroSefie.bounds.size)
        KF.url(url)
          .placeholder(UIImage(named: "placeholderImage"))
          .setProcessor(processor)
          .loadDiskFileSynchronously()
          .cacheMemoryOnly()
          .fade(duration: 0.25)
          .onProgress { _, _ in  }
          .onSuccess { _ in  }
          .onFailure { _ in }
          .set(to: heroSefie)
        
        loreLabel.text = viewModel.language.bio.htmlToString
    }
    
}
