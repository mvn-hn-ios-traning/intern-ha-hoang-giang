//
//  AllHeroCollectionViewCell.swift
//  Dota2Dictionary
//
//  Created by MacOS on 28/09/2021.
//

import UIKit
import Kingfisher

class AllHeroCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var heroAvatar: UIImageView!
    @IBOutlet weak var heroName: UILabel!
    
    let urlFirst = "https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = .black
    }
    
    func bind(_ viewModel: HeroItemViewModel) {
        self.heroName.text = viewModel.heroName
        
        let url = URL(string: "\(urlFirst)\(viewModel.heroAvatar).png")

        let processor = DownsamplingImageProcessor(size: heroAvatar.bounds.size)
        heroAvatar
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
